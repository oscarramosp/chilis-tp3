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
    
    public partial class tb_UnidadMedida
    {
        public tb_UnidadMedida()
        {
            this.Insumos = new HashSet<Insumos>();
        }
    
        public int codigo { get; set; }
        public string desMed { get; set; }
    
        public virtual ICollection<Insumos> Insumos { get; set; }
    }
}