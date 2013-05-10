


using System;
using SubSonic.Schema;
using System.Collections.Generic;
using SubSonic.DataProviders;
using System.Data;

namespace SICR.Persistencia {
	
        /// <summary>
        /// Table: MCliente
        /// Primary Key: CliCodigo
        /// </summary>

        public class MClienteTable: DatabaseTable {
            
            public MClienteTable(IDataProvider provider):base("MCliente",provider){
                ClassName = "MCliente";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("CliCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("CliRUC", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 15
                });

                Columns.Add(new DatabaseColumn("CliRazonSocial", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 60
                });

                Columns.Add(new DatabaseColumn("CliDireccion", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 60
                });

                Columns.Add(new DatabaseColumn("CliDistrito", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 50
                });

                Columns.Add(new DatabaseColumn("CliTelefono", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 15
                });

                Columns.Add(new DatabaseColumn("CliCelular", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 15
                });

                Columns.Add(new DatabaseColumn("CliCorreo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 60
                });

                Columns.Add(new DatabaseColumn("CliEstado", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiStringFixedLength,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 1
                });
                    
                
                
            }

            public IColumn CliCodigo{
                get{
                    return this.GetColumn("CliCodigo");
                }
            }
				
   			public static string CliCodigoColumn{
			      get{
        			return "CliCodigo";
      			}
		    }
            
            public IColumn CliRUC{
                get{
                    return this.GetColumn("CliRUC");
                }
            }
				
   			public static string CliRUCColumn{
			      get{
        			return "CliRUC";
      			}
		    }
            
            public IColumn CliRazonSocial{
                get{
                    return this.GetColumn("CliRazonSocial");
                }
            }
				
   			public static string CliRazonSocialColumn{
			      get{
        			return "CliRazonSocial";
      			}
		    }
            
            public IColumn CliDireccion{
                get{
                    return this.GetColumn("CliDireccion");
                }
            }
				
   			public static string CliDireccionColumn{
			      get{
        			return "CliDireccion";
      			}
		    }
            
            public IColumn CliDistrito{
                get{
                    return this.GetColumn("CliDistrito");
                }
            }
				
   			public static string CliDistritoColumn{
			      get{
        			return "CliDistrito";
      			}
		    }
            
            public IColumn CliTelefono{
                get{
                    return this.GetColumn("CliTelefono");
                }
            }
				
   			public static string CliTelefonoColumn{
			      get{
        			return "CliTelefono";
      			}
		    }
            
            public IColumn CliCelular{
                get{
                    return this.GetColumn("CliCelular");
                }
            }
				
   			public static string CliCelularColumn{
			      get{
        			return "CliCelular";
      			}
		    }
            
            public IColumn CliCorreo{
                get{
                    return this.GetColumn("CliCorreo");
                }
            }
				
   			public static string CliCorreoColumn{
			      get{
        			return "CliCorreo";
      			}
		    }
            
            public IColumn CliEstado{
                get{
                    return this.GetColumn("CliEstado");
                }
            }
				
   			public static string CliEstadoColumn{
			      get{
        			return "CliEstado";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MZona
        /// Primary Key: ZonCodigo
        /// </summary>

        public class MZonaTable: DatabaseTable {
            
            public MZonaTable(IDataProvider provider):base("MZona",provider){
                ClassName = "MZona";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("ZonCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("ZonNombre", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 45
                });

                Columns.Add(new DatabaseColumn("ZonEstado", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiStringFixedLength,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 1
                });
                    
                
                
            }

            public IColumn ZonCodigo{
                get{
                    return this.GetColumn("ZonCodigo");
                }
            }
				
   			public static string ZonCodigoColumn{
			      get{
        			return "ZonCodigo";
      			}
		    }
            
            public IColumn ZonNombre{
                get{
                    return this.GetColumn("ZonNombre");
                }
            }
				
   			public static string ZonNombreColumn{
			      get{
        			return "ZonNombre";
      			}
		    }
            
            public IColumn ZonEstado{
                get{
                    return this.GetColumn("ZonEstado");
                }
            }
				
   			public static string ZonEstadoColumn{
			      get{
        			return "ZonEstado";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MMesa
        /// Primary Key: MesCodigo
        /// </summary>

        public class MMesaTable: DatabaseTable {
            
            public MMesaTable(IDataProvider provider):base("MMesa",provider){
                ClassName = "MMesa";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("MesCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("MesNombre", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 45
                });

                Columns.Add(new DatabaseColumn("ZonCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("MesAsigna", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiStringFixedLength,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 1
                });

                Columns.Add(new DatabaseColumn("MesEstado", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiStringFixedLength,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 1
                });
                    
                
                
            }

            public IColumn MesCodigo{
                get{
                    return this.GetColumn("MesCodigo");
                }
            }
				
   			public static string MesCodigoColumn{
			      get{
        			return "MesCodigo";
      			}
		    }
            
            public IColumn MesNombre{
                get{
                    return this.GetColumn("MesNombre");
                }
            }
				
   			public static string MesNombreColumn{
			      get{
        			return "MesNombre";
      			}
		    }
            
            public IColumn ZonCodigo{
                get{
                    return this.GetColumn("ZonCodigo");
                }
            }
				
   			public static string ZonCodigoColumn{
			      get{
        			return "ZonCodigo";
      			}
		    }
            
            public IColumn MesAsigna{
                get{
                    return this.GetColumn("MesAsigna");
                }
            }
				
   			public static string MesAsignaColumn{
			      get{
        			return "MesAsigna";
      			}
		    }
            
            public IColumn MesEstado{
                get{
                    return this.GetColumn("MesEstado");
                }
            }
				
   			public static string MesEstadoColumn{
			      get{
        			return "MesEstado";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MAsignacion
        /// Primary Key: AsiCodigo
        /// </summary>

        public class MAsignacionTable: DatabaseTable {
            
            public MAsignacionTable(IDataProvider provider):base("MAsignacion",provider){
                ClassName = "MAsignacion";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("AsiCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = true,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("MesCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("AsiCantidad", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("AsiCliente", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 300
                });

                Columns.Add(new DatabaseColumn("AsiFecha", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.DateTime,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("AnfCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 10
                });
                    
                
                
            }

            public IColumn AsiCodigo{
                get{
                    return this.GetColumn("AsiCodigo");
                }
            }
				
   			public static string AsiCodigoColumn{
			      get{
        			return "AsiCodigo";
      			}
		    }
            
            public IColumn MesCodigo{
                get{
                    return this.GetColumn("MesCodigo");
                }
            }
				
   			public static string MesCodigoColumn{
			      get{
        			return "MesCodigo";
      			}
		    }
            
            public IColumn AsiCantidad{
                get{
                    return this.GetColumn("AsiCantidad");
                }
            }
				
   			public static string AsiCantidadColumn{
			      get{
        			return "AsiCantidad";
      			}
		    }
            
            public IColumn AsiCliente{
                get{
                    return this.GetColumn("AsiCliente");
                }
            }
				
   			public static string AsiClienteColumn{
			      get{
        			return "AsiCliente";
      			}
		    }
            
            public IColumn AsiFecha{
                get{
                    return this.GetColumn("AsiFecha");
                }
            }
				
   			public static string AsiFechaColumn{
			      get{
        			return "AsiFecha";
      			}
		    }
            
            public IColumn AnfCodigo{
                get{
                    return this.GetColumn("AnfCodigo");
                }
            }
				
   			public static string AnfCodigoColumn{
			      get{
        			return "AnfCodigo";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MEspecialidad
        /// Primary Key: EspCodigo
        /// </summary>

        public class MEspecialidadTable: DatabaseTable {
            
            public MEspecialidadTable(IDataProvider provider):base("MEspecialidad",provider){
                ClassName = "MEspecialidad";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("EspCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("EspNombre", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 50
                });
                    
                
                
            }

            public IColumn EspCodigo{
                get{
                    return this.GetColumn("EspCodigo");
                }
            }
				
   			public static string EspCodigoColumn{
			      get{
        			return "EspCodigo";
      			}
		    }
            
            public IColumn EspNombre{
                get{
                    return this.GetColumn("EspNombre");
                }
            }
				
   			public static string EspNombreColumn{
			      get{
        			return "EspNombre";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MPlatoBebida
        /// Primary Key: PlaCodigo
        /// </summary>

        public class MPlatoBebidaTable: DatabaseTable {
            
            public MPlatoBebidaTable(IDataProvider provider):base("MPlatoBebida",provider){
                ClassName = "MPlatoBebida";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("PlaCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("EspCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("PlaNombre", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 100
                });
                    
                
                
            }

            public IColumn PlaCodigo{
                get{
                    return this.GetColumn("PlaCodigo");
                }
            }
				
   			public static string PlaCodigoColumn{
			      get{
        			return "PlaCodigo";
      			}
		    }
            
            public IColumn EspCodigo{
                get{
                    return this.GetColumn("EspCodigo");
                }
            }
				
   			public static string EspCodigoColumn{
			      get{
        			return "EspCodigo";
      			}
		    }
            
            public IColumn PlaNombre{
                get{
                    return this.GetColumn("PlaNombre");
                }
            }
				
   			public static string PlaNombreColumn{
			      get{
        			return "PlaNombre";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MPedido
        /// Primary Key: PedCodigo
        /// </summary>

        public class MPedidoTable: DatabaseTable {
            
            public MPedidoTable(IDataProvider provider):base("MPedido",provider){
                ClassName = "MPedido";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("PedCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = true,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("OrdCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("SilCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("PlaCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("PedEstado", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 4
                });

                Columns.Add(new DatabaseColumn("PedCantidad", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });
                    
                
                
            }

            public IColumn PedCodigo{
                get{
                    return this.GetColumn("PedCodigo");
                }
            }
				
   			public static string PedCodigoColumn{
			      get{
        			return "PedCodigo";
      			}
		    }
            
            public IColumn OrdCodigo{
                get{
                    return this.GetColumn("OrdCodigo");
                }
            }
				
   			public static string OrdCodigoColumn{
			      get{
        			return "OrdCodigo";
      			}
		    }
            
            public IColumn SilCodigo{
                get{
                    return this.GetColumn("SilCodigo");
                }
            }
				
   			public static string SilCodigoColumn{
			      get{
        			return "SilCodigo";
      			}
		    }
            
            public IColumn PlaCodigo{
                get{
                    return this.GetColumn("PlaCodigo");
                }
            }
				
   			public static string PlaCodigoColumn{
			      get{
        			return "PlaCodigo";
      			}
		    }
            
            public IColumn PedEstado{
                get{
                    return this.GetColumn("PedEstado");
                }
            }
				
   			public static string PedEstadoColumn{
			      get{
        			return "PedEstado";
      			}
		    }
            
            public IColumn PedCantidad{
                get{
                    return this.GetColumn("PedCantidad");
                }
            }
				
   			public static string PedCantidadColumn{
			      get{
        			return "PedCantidad";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MOrden
        /// Primary Key: OrdCodigo
        /// </summary>

        public class MOrdenTable: DatabaseTable {
            
            public MOrdenTable(IDataProvider provider):base("MOrden",provider){
                ClassName = "MOrden";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("OrdCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = true,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("AsiCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("OrdFecha", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.DateTime,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });
                    
                
                
            }

            public IColumn OrdCodigo{
                get{
                    return this.GetColumn("OrdCodigo");
                }
            }
				
   			public static string OrdCodigoColumn{
			      get{
        			return "OrdCodigo";
      			}
		    }
            
            public IColumn AsiCodigo{
                get{
                    return this.GetColumn("AsiCodigo");
                }
            }
				
   			public static string AsiCodigoColumn{
			      get{
        			return "AsiCodigo";
      			}
		    }
            
            public IColumn OrdFecha{
                get{
                    return this.GetColumn("OrdFecha");
                }
            }
				
   			public static string OrdFechaColumn{
			      get{
        			return "OrdFecha";
      			}
		    }
            
                    
        }
        
        /// <summary>
        /// Table: MSilla
        /// Primary Key: SilCodigo
        /// </summary>

        public class MSillaTable: DatabaseTable {
            
            public MSillaTable(IDataProvider provider):base("MSilla",provider){
                ClassName = "MSilla";
                SchemaName = "dbo";
                

                Columns.Add(new DatabaseColumn("SilCodigo", this)
                {
	                IsPrimaryKey = true,
	                DataType = DbType.Int32,
	                IsNullable = false,
	                AutoIncrement = true,
	                IsForeignKey = false,
	                MaxLength = 0
                });

                Columns.Add(new DatabaseColumn("SilNombre", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.AnsiString,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 50
                });

                Columns.Add(new DatabaseColumn("MesCodigo", this)
                {
	                IsPrimaryKey = false,
	                DataType = DbType.Int32,
	                IsNullable = true,
	                AutoIncrement = false,
	                IsForeignKey = false,
	                MaxLength = 0
                });
                    
                
                
            }

            public IColumn SilCodigo{
                get{
                    return this.GetColumn("SilCodigo");
                }
            }
				
   			public static string SilCodigoColumn{
			      get{
        			return "SilCodigo";
      			}
		    }
            
            public IColumn SilNombre{
                get{
                    return this.GetColumn("SilNombre");
                }
            }
				
   			public static string SilNombreColumn{
			      get{
        			return "SilNombre";
      			}
		    }
            
            public IColumn MesCodigo{
                get{
                    return this.GetColumn("MesCodigo");
                }
            }
				
   			public static string MesCodigoColumn{
			      get{
        			return "MesCodigo";
      			}
		    }
            
                    
        }
        
}