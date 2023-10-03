using APP_CRUD.Models;
using APP_CRUD.Repositorios.Contrato;
using APP_CRUD.Repositorios.Implementaci�n;
using System.Data.SqlClient;
using System.Data;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

//Agregamos las referencias de nuestros repositorios gen�ricos
builder.Services.AddScoped<IGenericRepository<Departamento>, DepartamentoRepository>();
builder.Services.AddScoped<IGenericRepository<Personal>, PersonalRepository>();
builder.Services.AddScoped<IGenericRepository<Pais>, PaisRepository>();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
