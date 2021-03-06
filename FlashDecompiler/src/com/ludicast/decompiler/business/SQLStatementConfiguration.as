package com.ludicast.decompiler.business
{
	import com.ericfeminella.sql.ISQLStatementResource;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.resources.IResourceManager;
	
	public final class SQLStatementConfiguration implements ISQLStatementResource
	{
		[ResourceBundle('queries')]
		private static const resource:ResourceBundle;
		
		private static const rm:IResourceManager = ResourceManager.getInstance();
		
		public static const CREATE_SWF_TABLE:String = rm.getString("queries", "CREATE_SWF_TABLE");
		public static const CREATE_TAG_TABLE:String = rm.getString("queries", "CREATE_TAG_TABLE");		
		public static const INSERT_SWF:String = rm.getString("queries", "INSERT_SWF");
		public static const SELECT_ALL_SWFS:String = rm.getString("queries", "SELECT_ALL_SWFS");
		public static const SELECT_SWF_BY_ID:String = rm.getString("queries", "SELECT_SWF_BY_ID");

		public static const UPDATE:String = rm.getString("queries", "UPDATE");
		public static const DELETE:String = rm.getString("queries", "DELETE");
	}
}