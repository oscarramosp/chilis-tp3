


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SubSonic.DataProviders;
using SubSonic.Extensions;
using System.Linq.Expressions;
using SubSonic.Schema;
using System.Collections;
using SubSonic;
using SubSonic.Repository;
using System.ComponentModel;
using System.Data.Common;

namespace SICR.Persistencia
{
    
    
    /// <summary>
    /// A class which represents the MCliente table in the ORDEN Database.
    /// </summary>
    public partial class MCliente: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MCliente> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MCliente>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MCliente> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MCliente item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MCliente item=new MCliente();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MCliente> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MCliente(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MCliente.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MCliente>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MCliente(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MCliente(Expression<Func<MCliente, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MCliente> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MCliente> _repo;
            
            if(db.TestMode){
                MCliente.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MCliente>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MCliente> GetRepo(){
            return GetRepo("","");
        }
        
        public static MCliente SingleOrDefault(Expression<Func<MCliente, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MCliente single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MCliente SingleOrDefault(Expression<Func<MCliente, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MCliente single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MCliente, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MCliente, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MCliente> Find(Expression<Func<MCliente, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MCliente> Find(Expression<Func<MCliente, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MCliente> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MCliente> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MCliente> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MCliente> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MCliente> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MCliente> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "CliCodigo";
        }

        public object KeyValue()
        {
            return this.CliCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.CliRUC.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MCliente)){
                MCliente compare=(MCliente)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.CliCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.CliRUC.ToString();
                    }

        public string DescriptorColumn() {
            return "CliRUC";
        }
        public static string GetKeyColumn()
        {
            return "CliCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "CliRUC";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _CliCodigo;
        public int CliCodigo
        {
            get { return _CliCodigo; }
            set
            {
                if(_CliCodigo!=value){
                    _CliCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliRUC;
        public string CliRUC
        {
            get { return _CliRUC; }
            set
            {
                if(_CliRUC!=value){
                    _CliRUC=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliRUC");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliRazonSocial;
        public string CliRazonSocial
        {
            get { return _CliRazonSocial; }
            set
            {
                if(_CliRazonSocial!=value){
                    _CliRazonSocial=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliRazonSocial");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliDireccion;
        public string CliDireccion
        {
            get { return _CliDireccion; }
            set
            {
                if(_CliDireccion!=value){
                    _CliDireccion=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliDireccion");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliDistrito;
        public string CliDistrito
        {
            get { return _CliDistrito; }
            set
            {
                if(_CliDistrito!=value){
                    _CliDistrito=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliDistrito");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliTelefono;
        public string CliTelefono
        {
            get { return _CliTelefono; }
            set
            {
                if(_CliTelefono!=value){
                    _CliTelefono=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliTelefono");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliCelular;
        public string CliCelular
        {
            get { return _CliCelular; }
            set
            {
                if(_CliCelular!=value){
                    _CliCelular=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliCelular");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliCorreo;
        public string CliCorreo
        {
            get { return _CliCorreo; }
            set
            {
                if(_CliCorreo!=value){
                    _CliCorreo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliCorreo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _CliEstado;
        public string CliEstado
        {
            get { return _CliEstado; }
            set
            {
                if(_CliEstado!=value){
                    _CliEstado=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="CliEstado");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MCliente, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MZona table in the ORDEN Database.
    /// </summary>
    public partial class MZona: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MZona> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MZona>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MZona> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MZona item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MZona item=new MZona();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MZona> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MZona(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MZona.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MZona>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MZona(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MZona(Expression<Func<MZona, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MZona> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MZona> _repo;
            
            if(db.TestMode){
                MZona.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MZona>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MZona> GetRepo(){
            return GetRepo("","");
        }
        
        public static MZona SingleOrDefault(Expression<Func<MZona, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MZona single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MZona SingleOrDefault(Expression<Func<MZona, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MZona single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MZona, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MZona, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MZona> Find(Expression<Func<MZona, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MZona> Find(Expression<Func<MZona, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MZona> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MZona> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MZona> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MZona> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MZona> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MZona> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "ZonCodigo";
        }

        public object KeyValue()
        {
            return this.ZonCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.ZonNombre.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MZona)){
                MZona compare=(MZona)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.ZonCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.ZonNombre.ToString();
                    }

        public string DescriptorColumn() {
            return "ZonNombre";
        }
        public static string GetKeyColumn()
        {
            return "ZonCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "ZonNombre";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _ZonCodigo;
        public int ZonCodigo
        {
            get { return _ZonCodigo; }
            set
            {
                if(_ZonCodigo!=value){
                    _ZonCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="ZonCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _ZonNombre;
        public string ZonNombre
        {
            get { return _ZonNombre; }
            set
            {
                if(_ZonNombre!=value){
                    _ZonNombre=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="ZonNombre");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _ZonEstado;
        public string ZonEstado
        {
            get { return _ZonEstado; }
            set
            {
                if(_ZonEstado!=value){
                    _ZonEstado=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="ZonEstado");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MZona, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MMesa table in the ORDEN Database.
    /// </summary>
    public partial class MMesa: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MMesa> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MMesa>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MMesa> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MMesa item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MMesa item=new MMesa();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MMesa> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MMesa(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MMesa.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MMesa>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MMesa(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MMesa(Expression<Func<MMesa, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MMesa> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MMesa> _repo;
            
            if(db.TestMode){
                MMesa.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MMesa>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MMesa> GetRepo(){
            return GetRepo("","");
        }
        
        public static MMesa SingleOrDefault(Expression<Func<MMesa, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MMesa single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MMesa SingleOrDefault(Expression<Func<MMesa, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MMesa single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MMesa, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MMesa, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MMesa> Find(Expression<Func<MMesa, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MMesa> Find(Expression<Func<MMesa, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MMesa> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MMesa> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MMesa> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MMesa> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MMesa> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MMesa> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "MesCodigo";
        }

        public object KeyValue()
        {
            return this.MesCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.MesNombre.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MMesa)){
                MMesa compare=(MMesa)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.MesCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.MesNombre.ToString();
                    }

        public string DescriptorColumn() {
            return "MesNombre";
        }
        public static string GetKeyColumn()
        {
            return "MesCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "MesNombre";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _MesCodigo;
        public int MesCodigo
        {
            get { return _MesCodigo; }
            set
            {
                if(_MesCodigo!=value){
                    _MesCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _MesNombre;
        public string MesNombre
        {
            get { return _MesNombre; }
            set
            {
                if(_MesNombre!=value){
                    _MesNombre=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesNombre");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _ZonCodigo;
        public int? ZonCodigo
        {
            get { return _ZonCodigo; }
            set
            {
                if(_ZonCodigo!=value){
                    _ZonCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="ZonCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _MesAsigna;
        public string MesAsigna
        {
            get { return _MesAsigna; }
            set
            {
                if(_MesAsigna!=value){
                    _MesAsigna=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesAsigna");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _MesEstado;
        public string MesEstado
        {
            get { return _MesEstado; }
            set
            {
                if(_MesEstado!=value){
                    _MesEstado=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesEstado");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MMesa, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MAsignacion table in the ORDEN Database.
    /// </summary>
    public partial class MAsignacion: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MAsignacion> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MAsignacion>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MAsignacion> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MAsignacion item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MAsignacion item=new MAsignacion();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MAsignacion> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MAsignacion(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MAsignacion.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MAsignacion>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MAsignacion(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MAsignacion(Expression<Func<MAsignacion, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MAsignacion> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MAsignacion> _repo;
            
            if(db.TestMode){
                MAsignacion.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MAsignacion>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MAsignacion> GetRepo(){
            return GetRepo("","");
        }
        
        public static MAsignacion SingleOrDefault(Expression<Func<MAsignacion, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MAsignacion single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MAsignacion SingleOrDefault(Expression<Func<MAsignacion, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MAsignacion single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MAsignacion, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MAsignacion, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MAsignacion> Find(Expression<Func<MAsignacion, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MAsignacion> Find(Expression<Func<MAsignacion, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MAsignacion> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MAsignacion> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MAsignacion> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MAsignacion> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MAsignacion> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MAsignacion> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "AsiCodigo";
        }

        public object KeyValue()
        {
            return this.AsiCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.AsiCliente.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MAsignacion)){
                MAsignacion compare=(MAsignacion)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.AsiCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.AsiCliente.ToString();
                    }

        public string DescriptorColumn() {
            return "AsiCliente";
        }
        public static string GetKeyColumn()
        {
            return "AsiCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "AsiCliente";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _AsiCodigo;
        public int AsiCodigo
        {
            get { return _AsiCodigo; }
            set
            {
                if(_AsiCodigo!=value){
                    _AsiCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AsiCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _MesCodigo;
        public int? MesCodigo
        {
            get { return _MesCodigo; }
            set
            {
                if(_MesCodigo!=value){
                    _MesCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _AsiCantidad;
        public int? AsiCantidad
        {
            get { return _AsiCantidad; }
            set
            {
                if(_AsiCantidad!=value){
                    _AsiCantidad=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AsiCantidad");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _AsiCliente;
        public string AsiCliente
        {
            get { return _AsiCliente; }
            set
            {
                if(_AsiCliente!=value){
                    _AsiCliente=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AsiCliente");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        DateTime? _AsiFecha;
        public DateTime? AsiFecha
        {
            get { return _AsiFecha; }
            set
            {
                if(_AsiFecha!=value){
                    _AsiFecha=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AsiFecha");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _AnfCodigo;
        public string AnfCodigo
        {
            get { return _AnfCodigo; }
            set
            {
                if(_AnfCodigo!=value){
                    _AnfCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AnfCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MAsignacion, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MEspecialidad table in the ORDEN Database.
    /// </summary>
    public partial class MEspecialidad: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MEspecialidad> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MEspecialidad>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MEspecialidad> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MEspecialidad item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MEspecialidad item=new MEspecialidad();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MEspecialidad> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MEspecialidad(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MEspecialidad.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MEspecialidad>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MEspecialidad(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MEspecialidad(Expression<Func<MEspecialidad, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MEspecialidad> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MEspecialidad> _repo;
            
            if(db.TestMode){
                MEspecialidad.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MEspecialidad>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MEspecialidad> GetRepo(){
            return GetRepo("","");
        }
        
        public static MEspecialidad SingleOrDefault(Expression<Func<MEspecialidad, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MEspecialidad single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MEspecialidad SingleOrDefault(Expression<Func<MEspecialidad, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MEspecialidad single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MEspecialidad, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MEspecialidad, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MEspecialidad> Find(Expression<Func<MEspecialidad, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MEspecialidad> Find(Expression<Func<MEspecialidad, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MEspecialidad> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MEspecialidad> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MEspecialidad> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MEspecialidad> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MEspecialidad> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MEspecialidad> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "EspCodigo";
        }

        public object KeyValue()
        {
            return this.EspCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.EspNombre.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MEspecialidad)){
                MEspecialidad compare=(MEspecialidad)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.EspCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.EspNombre.ToString();
                    }

        public string DescriptorColumn() {
            return "EspNombre";
        }
        public static string GetKeyColumn()
        {
            return "EspCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "EspNombre";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _EspCodigo;
        public int EspCodigo
        {
            get { return _EspCodigo; }
            set
            {
                if(_EspCodigo!=value){
                    _EspCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="EspCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _EspNombre;
        public string EspNombre
        {
            get { return _EspNombre; }
            set
            {
                if(_EspNombre!=value){
                    _EspNombre=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="EspNombre");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MEspecialidad, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MPlatoBebida table in the ORDEN Database.
    /// </summary>
    public partial class MPlatoBebida: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MPlatoBebida> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MPlatoBebida>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MPlatoBebida> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MPlatoBebida item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MPlatoBebida item=new MPlatoBebida();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MPlatoBebida> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MPlatoBebida(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MPlatoBebida.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MPlatoBebida>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MPlatoBebida(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MPlatoBebida(Expression<Func<MPlatoBebida, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MPlatoBebida> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MPlatoBebida> _repo;
            
            if(db.TestMode){
                MPlatoBebida.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MPlatoBebida>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MPlatoBebida> GetRepo(){
            return GetRepo("","");
        }
        
        public static MPlatoBebida SingleOrDefault(Expression<Func<MPlatoBebida, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MPlatoBebida single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MPlatoBebida SingleOrDefault(Expression<Func<MPlatoBebida, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MPlatoBebida single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MPlatoBebida, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MPlatoBebida, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MPlatoBebida> Find(Expression<Func<MPlatoBebida, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MPlatoBebida> Find(Expression<Func<MPlatoBebida, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MPlatoBebida> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MPlatoBebida> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MPlatoBebida> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MPlatoBebida> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MPlatoBebida> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MPlatoBebida> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "PlaCodigo";
        }

        public object KeyValue()
        {
            return this.PlaCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.PlaNombre.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MPlatoBebida)){
                MPlatoBebida compare=(MPlatoBebida)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.PlaCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.PlaNombre.ToString();
                    }

        public string DescriptorColumn() {
            return "PlaNombre";
        }
        public static string GetKeyColumn()
        {
            return "PlaCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "PlaNombre";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _PlaCodigo;
        public int PlaCodigo
        {
            get { return _PlaCodigo; }
            set
            {
                if(_PlaCodigo!=value){
                    _PlaCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PlaCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _EspCodigo;
        public int? EspCodigo
        {
            get { return _EspCodigo; }
            set
            {
                if(_EspCodigo!=value){
                    _EspCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="EspCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _PlaNombre;
        public string PlaNombre
        {
            get { return _PlaNombre; }
            set
            {
                if(_PlaNombre!=value){
                    _PlaNombre=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PlaNombre");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MPlatoBebida, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MPedido table in the ORDEN Database.
    /// </summary>
    public partial class MPedido: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MPedido> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MPedido>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MPedido> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MPedido item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MPedido item=new MPedido();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MPedido> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MPedido(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MPedido.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MPedido>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MPedido(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MPedido(Expression<Func<MPedido, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MPedido> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MPedido> _repo;
            
            if(db.TestMode){
                MPedido.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MPedido>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MPedido> GetRepo(){
            return GetRepo("","");
        }
        
        public static MPedido SingleOrDefault(Expression<Func<MPedido, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MPedido single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MPedido SingleOrDefault(Expression<Func<MPedido, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MPedido single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MPedido, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MPedido, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MPedido> Find(Expression<Func<MPedido, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MPedido> Find(Expression<Func<MPedido, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MPedido> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MPedido> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MPedido> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MPedido> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MPedido> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MPedido> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "PedCodigo";
        }

        public object KeyValue()
        {
            return this.PedCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.PedEstado.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MPedido)){
                MPedido compare=(MPedido)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.PedCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.PedEstado.ToString();
                    }

        public string DescriptorColumn() {
            return "PedEstado";
        }
        public static string GetKeyColumn()
        {
            return "PedCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "PedEstado";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _PedCodigo;
        public int PedCodigo
        {
            get { return _PedCodigo; }
            set
            {
                if(_PedCodigo!=value){
                    _PedCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PedCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _OrdCodigo;
        public int? OrdCodigo
        {
            get { return _OrdCodigo; }
            set
            {
                if(_OrdCodigo!=value){
                    _OrdCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="OrdCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _SilCodigo;
        public int? SilCodigo
        {
            get { return _SilCodigo; }
            set
            {
                if(_SilCodigo!=value){
                    _SilCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="SilCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _PlaCodigo;
        public int? PlaCodigo
        {
            get { return _PlaCodigo; }
            set
            {
                if(_PlaCodigo!=value){
                    _PlaCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PlaCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _PedEstado;
        public string PedEstado
        {
            get { return _PedEstado; }
            set
            {
                if(_PedEstado!=value){
                    _PedEstado=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PedEstado");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _PedCantidad;
        public int? PedCantidad
        {
            get { return _PedCantidad; }
            set
            {
                if(_PedCantidad!=value){
                    _PedCantidad=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="PedCantidad");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MPedido, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MOrden table in the ORDEN Database.
    /// </summary>
    public partial class MOrden: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MOrden> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MOrden>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MOrden> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MOrden item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MOrden item=new MOrden();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MOrden> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MOrden(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MOrden.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MOrden>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MOrden(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MOrden(Expression<Func<MOrden, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MOrden> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MOrden> _repo;
            
            if(db.TestMode){
                MOrden.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MOrden>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MOrden> GetRepo(){
            return GetRepo("","");
        }
        
        public static MOrden SingleOrDefault(Expression<Func<MOrden, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MOrden single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MOrden SingleOrDefault(Expression<Func<MOrden, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MOrden single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MOrden, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MOrden, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MOrden> Find(Expression<Func<MOrden, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MOrden> Find(Expression<Func<MOrden, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MOrden> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MOrden> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MOrden> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MOrden> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MOrden> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MOrden> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "OrdCodigo";
        }

        public object KeyValue()
        {
            return this.OrdCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.AsiCodigo.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MOrden)){
                MOrden compare=(MOrden)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.OrdCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.AsiCodigo.ToString();
                    }

        public string DescriptorColumn() {
            return "AsiCodigo";
        }
        public static string GetKeyColumn()
        {
            return "OrdCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "AsiCodigo";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _OrdCodigo;
        public int OrdCodigo
        {
            get { return _OrdCodigo; }
            set
            {
                if(_OrdCodigo!=value){
                    _OrdCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="OrdCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _AsiCodigo;
        public int? AsiCodigo
        {
            get { return _AsiCodigo; }
            set
            {
                if(_AsiCodigo!=value){
                    _AsiCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="AsiCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        DateTime? _OrdFecha;
        public DateTime? OrdFecha
        {
            get { return _OrdFecha; }
            set
            {
                if(_OrdFecha!=value){
                    _OrdFecha=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="OrdFecha");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MOrden, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
    
    
    /// <summary>
    /// A class which represents the MSilla table in the ORDEN Database.
    /// </summary>
    public partial class MSilla: IActiveRecord
    {
    
        #region Built-in testing
        static TestRepository<MSilla> _testRepo;
        

        
        static void SetTestRepo(){
            _testRepo = _testRepo ?? new TestRepository<MSilla>(new SICR.Persistencia.ORDENDB());
        }
        public static void ResetTestRepo(){
            _testRepo = null;
            SetTestRepo();
        }
        public static void Setup(List<MSilla> testlist){
            SetTestRepo();
            foreach (var item in testlist)
            {
                _testRepo._items.Add(item);
            }
        }
        public static void Setup(MSilla item) {
            SetTestRepo();
            _testRepo._items.Add(item);
        }
        public static void Setup(int testItems) {
            SetTestRepo();
            for(int i=0;i<testItems;i++){
                MSilla item=new MSilla();
                _testRepo._items.Add(item);
            }
        }
        
        public bool TestMode = false;


        #endregion

        IRepository<MSilla> _repo;
        ITable tbl;
        bool _isNew;
        public bool IsNew(){
            return _isNew;
        }
        
        public void SetIsLoaded(bool isLoaded){
            _isLoaded=isLoaded;
            if(isLoaded)
                OnLoaded();
        }
        
        public void SetIsNew(bool isNew){
            _isNew=isNew;
        }
        bool _isLoaded;
        public bool IsLoaded(){
            return _isLoaded;
        }
                
        List<IColumn> _dirtyColumns;
        public bool IsDirty(){
            return _dirtyColumns.Count>0;
        }
        
        public List<IColumn> GetDirtyColumns (){
            return _dirtyColumns;
        }

        SICR.Persistencia.ORDENDB _db;
        public MSilla(string connectionString, string providerName) {

            _db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            Init();            
         }
        void Init(){
            TestMode=this._db.DataProvider.ConnectionString.Equals("test", StringComparison.InvariantCultureIgnoreCase);
            _dirtyColumns=new List<IColumn>();
            if(TestMode){
                MSilla.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MSilla>(_db);
            }
            tbl=_repo.GetTable();
            SetIsNew(true);
            OnCreated();       

        }
        
        public MSilla(){
             _db=new SICR.Persistencia.ORDENDB();
            Init();            
        }
        
       
        partial void OnCreated();
            
        partial void OnLoaded();
        
        partial void OnSaved();
        
        partial void OnChanged();
        
        public IList<IColumn> Columns{
            get{
                return tbl.Columns;
            }
        }

        public MSilla(Expression<Func<MSilla, bool>> expression):this() {

            SetIsLoaded(_repo.Load(this,expression));
        }
        
       
        
        internal static IRepository<MSilla> GetRepo(string connectionString, string providerName){
            SICR.Persistencia.ORDENDB db;
            if(String.IsNullOrEmpty(connectionString)){
                db=new SICR.Persistencia.ORDENDB();
            }else{
                db=new SICR.Persistencia.ORDENDB(connectionString, providerName);
            }
            IRepository<MSilla> _repo;
            
            if(db.TestMode){
                MSilla.SetTestRepo();
                _repo=_testRepo;
            }else{
                _repo = new SubSonicRepository<MSilla>(db);
            }
            return _repo;        
        }       
        
        internal static IRepository<MSilla> GetRepo(){
            return GetRepo("","");
        }
        
        public static MSilla SingleOrDefault(Expression<Func<MSilla, bool>> expression) {

            var repo = GetRepo();
            var results=repo.Find(expression);
            MSilla single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
                single.OnLoaded();
                single.SetIsLoaded(true);
                single.SetIsNew(false);
            }

            return single;
        }      
        
        public static MSilla SingleOrDefault(Expression<Func<MSilla, bool>> expression,string connectionString, string providerName) {
            var repo = GetRepo(connectionString,providerName);
            var results=repo.Find(expression);
            MSilla single=null;
            if(results.Count() > 0){
                single=results.ToList()[0];
            }

            return single;


        }
        
        
        public static bool Exists(Expression<Func<MSilla, bool>> expression,string connectionString, string providerName) {
           
            return All(connectionString,providerName).Any(expression);
        }        
        public static bool Exists(Expression<Func<MSilla, bool>> expression) {
           
            return All().Any(expression);
        }        

        public static IList<MSilla> Find(Expression<Func<MSilla, bool>> expression) {
            
            var repo = GetRepo();
            return repo.Find(expression).ToList();
        }
        
        public static IList<MSilla> Find(Expression<Func<MSilla, bool>> expression,string connectionString, string providerName) {

            var repo = GetRepo(connectionString,providerName);
            return repo.Find(expression).ToList();

        }
        public static IQueryable<MSilla> All(string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetAll();
        }
        public static IQueryable<MSilla> All() {
            return GetRepo().GetAll();
        }
        
        public static PagedList<MSilla> GetPaged(string sortBy, int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(sortBy, pageIndex, pageSize);
        }
      
        public static PagedList<MSilla> GetPaged(string sortBy, int pageIndex, int pageSize) {
            return GetRepo().GetPaged(sortBy, pageIndex, pageSize);
        }

        public static PagedList<MSilla> GetPaged(int pageIndex, int pageSize,string connectionString, string providerName) {
            return GetRepo(connectionString,providerName).GetPaged(pageIndex, pageSize);
            
        }


        public static PagedList<MSilla> GetPaged(int pageIndex, int pageSize) {
            return GetRepo().GetPaged(pageIndex, pageSize);
            
        }

        public string KeyName()
        {
            return "SilCodigo";
        }

        public object KeyValue()
        {
            return this.SilCodigo;
        }
        
        public void SetKeyValue(object value) {
            if (value != null && value!=DBNull.Value) {
                var settable = value.ChangeTypeTo<int>();
                this.GetType().GetProperty(this.KeyName()).SetValue(this, settable, null);
            }
        }
        
        public override string ToString(){
                            return this.SilNombre.ToString();
                    }

        public override bool Equals(object obj){
            if(obj.GetType()==typeof(MSilla)){
                MSilla compare=(MSilla)obj;
                return compare.KeyValue()==this.KeyValue();
            }else{
                return base.Equals(obj);
            }
        }

        
        public override int GetHashCode() {
            return this.SilCodigo;
        }
        
        public string DescriptorValue()
        {
                            return this.SilNombre.ToString();
                    }

        public string DescriptorColumn() {
            return "SilNombre";
        }
        public static string GetKeyColumn()
        {
            return "SilCodigo";
        }        
        public static string GetDescriptorColumn()
        {
            return "SilNombre";
        }
        
        #region ' Foreign Keys '
        #endregion
        

        int _SilCodigo;
        public int SilCodigo
        {
            get { return _SilCodigo; }
            set
            {
                if(_SilCodigo!=value){
                    _SilCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="SilCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        string _SilNombre;
        public string SilNombre
        {
            get { return _SilNombre; }
            set
            {
                if(_SilNombre!=value){
                    _SilNombre=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="SilNombre");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }

        int? _MesCodigo;
        public int? MesCodigo
        {
            get { return _MesCodigo; }
            set
            {
                if(_MesCodigo!=value){
                    _MesCodigo=value;
                    var col=tbl.Columns.SingleOrDefault(x=>x.Name=="MesCodigo");
                    if(col!=null){
                        if(!_dirtyColumns.Any(x=>x.Name==col.Name) && _isLoaded){
                            _dirtyColumns.Add(col);
                        }
                    }
                    OnChanged();
                }
            }
        }



        public DbCommand GetUpdateCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToUpdateQuery(_db.Provider).GetCommand().ToDbCommand();
            
        }
        public DbCommand GetInsertCommand() {
 
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToInsertQuery(_db.Provider).GetCommand().ToDbCommand();
        }
        
        public DbCommand GetDeleteCommand() {
            if(TestMode)
                return _db.DataProvider.CreateCommand();
            else
                return this.ToDeleteQuery(_db.Provider).GetCommand().ToDbCommand();
        }
       
        
        public void Update(){
            Update(_db.DataProvider);
        }
        
        public void Update(IDataProvider provider){
        
            
            if(this._dirtyColumns.Count>0){
                _repo.Update(this,provider);
                _dirtyColumns.Clear();    
            }
            OnSaved();
       }
 
        public void Add(){
            Add(_db.DataProvider);
        }
        
        
       
        public void Add(IDataProvider provider){

            
            var key=KeyValue();
            if(key==null){
                var newKey=_repo.Add(this,provider);
                this.SetKeyValue(newKey);
            }else{
                _repo.Add(this,provider);
            }
            SetIsNew(false);
            OnSaved();
        }
        
                
        
        public void Save() {
            Save(_db.DataProvider);
        }      
        public void Save(IDataProvider provider) {
            
           
            if (_isNew) {
                Add(provider);
                
            } else {
                Update(provider);
            }
            
        }

        

        public void Delete(IDataProvider provider) {
                   
                 
            _repo.Delete(KeyValue());
            
                    }


        public void Delete() {
            Delete(_db.DataProvider);
        }


        public static void Delete(Expression<Func<MSilla, bool>> expression) {
            var repo = GetRepo();
            
       
            
            repo.DeleteMany(expression);
            
        }

        

        public void Load(IDataReader rdr) {
            Load(rdr, true);
        }
        public void Load(IDataReader rdr, bool closeReader) {
            if (rdr.Read()) {

                try {
                    rdr.Load(this);
                    SetIsNew(false);
                    SetIsLoaded(true);
                } catch {
                    SetIsLoaded(false);
                    throw;
                }
            }else{
                SetIsLoaded(false);
            }

            if (closeReader)
                rdr.Dispose();
        }
        

    } 
}
