//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sisres.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Recetas
    {
        public Recetas()
        {
            this.Carta = new HashSet<Carta>();
            this.InsumosPorReceta = new HashSet<InsumosPorReceta>();
            this.Ordenes = new HashSet<Ordenes>();
        }
    
        public int IdReceta { get; set; }
        public string NombreReceta { get; set; }
        public int IdTipoReceta { get; set; }
        public decimal Costo { get; set; }
        public int TiempoPreparacion { get; set; }
        public int ValorNutricional { get; set; }
        public string ModoPreparacion { get; set; }
        public decimal Precio { get; set; }
    
        public virtual TiposReceta TiposReceta { get; set; }
        public virtual ICollection<Carta> Carta { get; set; }
        public virtual ICollection<InsumosPorReceta> InsumosPorReceta { get; set; }
        public virtual ICollection<Ordenes> Ordenes { get; set; }
    }
}