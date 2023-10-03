using APP_CRUD.Models;
using APP_CRUD.Repositorios.Contrato;
using System.Data.SqlClient;

namespace APP_CRUD.Repositorios.Implementación
{
    public class PaisRepository : IGenericRepository<Pais>
    {
        private readonly string cadena = "";
        public PaisRepository(IConfiguration c)
        {
            cadena = c.GetConnectionString("cadenaSQL");
        }

        public Task<bool> Editar(Pais modelo)
        {
            throw new NotImplementedException();
        }

        public Task<bool> Eliminar(int id)
        {
            throw new NotImplementedException();
        }

        public Task<bool> Guardar(Pais modelo)
        {
            throw new NotImplementedException();
        }

        public async Task<List<Pais>> Listar()
        {
                List<Pais> lista = new List<Pais>();

            using(var sql = new SqlConnection(cadena))
            {
                sql.Open();
                using (SqlCommand cmd = new SqlCommand("pa_ListaPais",sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using(SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            lista.Add(new Pais
                            {
                                id_pais = (int)reader[0],
                                name_pais = (string)reader[1]
                            });
                        }
                    }
                }
            }
            return lista;

        }
    }
}
