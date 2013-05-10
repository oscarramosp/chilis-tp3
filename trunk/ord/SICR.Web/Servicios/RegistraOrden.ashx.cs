using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SICR.LogicaNegocio;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using SICR.Persistencia;

namespace SICR.Web.Servicios
{
    /// <summary>
    /// Summary description for RegistraOrden
    /// </summary>
    public class RegistraOrdenService : IHttpHandler
    {
        public static string JsonSerializer<T>(T t)
        {
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));

            MemoryStream ms = new MemoryStream();
            ser.WriteObject(ms, t);
            string jsonString = Encoding.UTF8.GetString(ms.ToArray());
            ms.Close();
            return jsonString;
        }
        public static T JsonDeserialize<T>(string jsonString)
        {
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
            T obj = (T)ser.ReadObject(ms);
            return obj;
        }

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";
            if (context.Request["consulta"] == "1")
            {

                
                    int codMesa=int.Parse(context.Request["MesCodigo"]);
                    Catalogo res =new Catalogo();
                    MAsignacion asin = RegistroOrden.BuscarAsignacion(codMesa);
                    res.Nombre = asin.AnfCodigo;
                    res.Codigo = asin.AsiCodigo;
                    res.Items = (from s in RegistroOrden.ObtenerSillas(codMesa) select new Catalogo { Codigo=s.SilCodigo , Nombre=s.SilNombre }).ToArray();
                    context.Response.Write(JsonSerializer(res));
                
            }else if (context.Request["consulta"] == "2")
            {
                try
                {
                    var lista = RegistroOrden.ObtenerPlatoBebida(int.Parse(context.Request["EspCodigo"]));
                    context.Response.Write(JsonSerializer((from p in lista select new Catalogo { Codigo = p.PlaCodigo, Nombre = p.PlaNombre })));

                }
                catch (FormatException )
                {
                    //el código de mesa ingresado no tiene el formato correcto
                    context.Response.Write("-1");
                }
            }else if (context.Request["consulta"] == "3")
            {
                MPedido[] p=JsonDeserialize<MPedido[]>(context.Request["pedido"]);
                RegistroOrden.GuardarPedido(p);
            }
        }

        public class Catalogo
        {
            public int Codigo { get; set; }
            public string Nombre { get; set; }

            public Catalogo[] Items { get;set; }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}