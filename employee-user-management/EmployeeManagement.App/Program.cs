using Azure.Identity;
using Azure.Security.KeyVault.Secrets; // Needed for Key Vault
using EmployeeManagement.App.Data;
using EmployeeManagement.App.Repository;
using EmployeeManagement.App.Service;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

string connectionString;

if (!builder.Environment.IsDevelopment())
{
    // 1. Load Key Vault into configuration
    var keyVaultUrl = new Uri(builder.Configuration["KeyVaultUrl"]!);
    var credential = new DefaultAzureCredential();
    builder.Configuration.AddAzureKeyVault(keyVaultUrl, credential);

    // 2. Get the name of the secret from configuration
    var secretName = builder.Configuration["ConnectionStrings__DefaultConnectionSecretName"];

    if (string.IsNullOrEmpty(secretName))
    {
        throw new InvalidOperationException("Missing 'ConnectionStrings__DefaultConnectionSecretName' in configuration.");
    }

    // 3. Use Azure SDK to fetch the secret value from Key Vault
    var secretClient = new SecretClient(keyVaultUrl, credential);
    var secret = await secretClient.GetSecretAsync(secretName);
    connectionString = secret.Value.Value;

    if (string.IsNullOrEmpty(connectionString))
    {
        throw new InvalidOperationException("Connection string from Key Vault is empty.");
    }
}
else
{
    // Local dev: get from appsettings.json or environment variable
    connectionString = builder.Configuration.GetConnectionString("EmployeeDbConnection")
                       ?? Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection");

    if (string.IsNullOrEmpty(connectionString))
    {
        throw new InvalidOperationException("No connection string found in local configuration or environment variables.");
    }
}

// Register EF Core DbContext
builder.Services.AddDbContext<EmployeeDbContext>(options =>
    options.UseSqlServer(connectionString));

// Register employee-related services and repositories
builder.Services.AddScoped<IEmployeeRepository, EmployeeRepository>();
builder.Services.AddScoped<IEmployeeService, EmployeeService>();

builder.Services.AddScoped<IContactRepository, ContactRepository>();
builder.Services.AddScoped<IContactService, ContactService>();

// Register AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();  
app.UseAuthorization();

app.UseStatusCodePagesWithReExecute("/Error/{0}");

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
