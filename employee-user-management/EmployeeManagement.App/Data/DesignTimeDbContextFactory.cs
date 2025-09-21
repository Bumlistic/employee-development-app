using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;

namespace EmployeeManagement.App.Data
{
    public class DesignTimeDbContextFactory : IDesignTimeDbContextFactory<EmployeeDbContext>
    {
        public EmployeeDbContext CreateDbContext(string[] args)
        {
            // Build configuration to read environment variables or appsettings.json
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true)
                .AddEnvironmentVariables(); // read ConnectionStrings__DefaultConnection from pipeline

            var configuration = builder.Build();

            var optionsBuilder = new DbContextOptionsBuilder<EmployeeDbContext>();

            var connectionString = configuration.GetConnectionString("DefaultConnection")
                                  ?? Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection");

            if (string.IsNullOrEmpty(connectionString))
            {
                throw new InvalidOperationException("Connection string not found. Make sure ConnectionStrings__DefaultConnection is set.");
            }

            optionsBuilder.UseSqlServer(connectionString);

            return new EmployeeDbContext(optionsBuilder.Options);
        }
    }
}
