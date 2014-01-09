//处理与stamp表相关的业务逻辑

package version1.model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class GoodsBeanBO {
	
	private ResultSet rs=null;
	private Connection ct=null;
	private PreparedStatement ps=null;
	private PreparedStatement ps1=null;
	String sql=null;
	String sql1=null;

	/**
	 * 保存邮票的详细信息到stamp和groups这两张表中
	 * @param id 邮票id
	 * @param stampDate发行日期
	 * @param stampTitle 邮票名字
	 * @param stampType 邮票类型
	 * @param stampValue 邮票面值
	 * @param stampSize 邮票大小
	 * @param stampDesigner 邮票设计者
	 * @param stampPublisher 邮票发行单位
	 * @param groupTag 组标签
	 * @param groupNum 组邮票数目
	 * @param groupFromDate 组起始时间
	 * @param groupFinishDate 组终止时间
	 * @return 保存成功返回true ,失败返回false
	 */
	public boolean saveAllData(String id , int stampDate, String stampTitle,String stampType,String stampValue,String stampSize,String stampDesigner,String stampPublisher,String groupTag,int groupNum,String groupFromDate,String groupFinishDate){
		boolean flag=false;
		int result=-1;
		int result1=-1;
		//System.out.println(id+year+country);
		try{
			sql="update stamp SET stampDate='"+stampDate+"',stampTitle='"+stampTitle+"',stampType='"+stampType+"',stampValue='"+stampValue+"',stampSize='"+stampSize+"',stampDesigner='"+stampDesigner+"',stampPublisher='"+stampPublisher+"' where stampId='"+id+"'";
			sql1="update groups SET groups.groupTag='"+groupTag+"',groups.groupStampNum='"+groupNum+"',groups.groupFromDate='"+groupFromDate+"',groups.groupFinishDate='"+groupFinishDate+"'where groups.groupId in (select stamp.stampInGroupId from stamp where stamp.stampId='"+id+"')";
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement(sql);
			ps1=ct.prepareStatement(sql1);
			
			/*ps.setString(1,year);
			ps.setString(2,country);
			ps.setString(3,id);*/
			result=ps.executeUpdate();
			result1=ps1.executeUpdate();
			if(result>=0 && result1>=0){
				flag=true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		//System.out.println(flag);
		return flag;
	}
	
	//保存邮票的详细信息到task表中
		/**
		 * 保存邮票的详细信息到task表中
		 * @param taskName 任务名称
		 * @param taskAmount 任务数量
		 * @param taskPerson 任务人选
		 * @param taskTable 任务数据库表单
		 * @param taskStartId 任务起始ID
		 * @param taskFinishId 任务结束ID
		 * @param taskDescribe 任务描述
		 */
	public boolean saveTaskData(int taskId,String taskName,int taskAmount,String taskPerson,String taskTable,String taskStartId,String taskFinishId,String taskNowId,String taskFlag,String taskDescribe,String taskDetail){
		boolean flag=false;
		int result=-1;
		if("false".contentEquals(taskFlag))
			taskFlag="未完成";
		else
			taskFlag="已完成";
		try{
			if(!checkTaskId(taskId)){
				sql="insert into task values ('" + taskId + "','" + taskName + "','" + taskAmount + "','" + taskPerson + "','" + taskTable + "','" + taskStartId + "','" + taskFinishId + "','" + taskNowId + "','" + taskFlag + "','" + taskDescribe + "','" + taskDetail + "')";
				ct=new ConnDB().getConn();
				ps=ct.prepareStatement(sql);
				result=ps.executeUpdate();
				if(result>=0){
					flag=true;
				}
			}
			else
				System.out.println("添加任务条目ID重复！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		//System.out.println(flag);
		return flag;
	}
	
	//保存邮票的详细信息到stamp表中
	public boolean saveStampData(String stampId,String stampInGroupTitle,int stampDate,String stampTitle,String stampType,String stampValue,String stampSize,String stampDesigner,String stampPublisher){
		boolean flag=false;
		int result=-1;
		try{
			sql="update stamp set stampInGroupTitle='" + stampInGroupTitle + "',stampDate='" + stampDate + "',stampTitle='" + stampTitle + "',stampType='" + stampType + "',stampValue='" + stampValue + "',stampSize='" + stampSize + "',stampDesigner='" + stampDesigner + "',stampPublisher='" + stampPublisher + "' where stampId='" + stampId + "'";
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement(sql);
			result=ps.executeUpdate();
			if(result>=0){
				flag=true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return flag;
	}
	
	//保存邮票的详细信息到groups表中
	public boolean saveGroupsData(String groupId,String groupTitle,String groupTag,int groupStampNum,String groupFromDate,String groupFinishDate){
		boolean flag=false;
		int result=-1;
		try{
			sql="update groups set groupTitle='" + groupTitle + "',groupTag='" + groupTag + "',groupStampNum='" + groupStampNum + "',groupFromDate='" + groupFromDate + "',groupFinishDate='" + groupFinishDate + "' where groupId='" + groupId + "'";
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement(sql);
			result=ps.executeUpdate();
			if(result>=0){
				flag=true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return flag;
	}
	
	//通过taskId找到任务条目，然后删除。
	public boolean deleteTaskData(int taskId){
		boolean flag=false;
		int result=-1;
		
		try{
			if(checkTaskId(taskId)){
				sql="delete from task where taskId="+taskId;
				ct=new ConnDB().getConn();
				ps=ct.prepareStatement(sql);
				result=ps.executeUpdate();
				if(result>=1){
					flag=true;
				}
			}
			else
				System.out.println("删除任务条目不存在！");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return flag;
	}
	
	//检查任务ID是否存在
	public boolean checkTaskId(int taskId){
		boolean flag=false;   
		
		try{
			sql="select * from task where taskId=?";
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement(sql);
			ps.setInt(1,taskId);
			rs=ps.executeQuery();
			if(rs.next())
				flag=true;
			else
				flag=false;	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return flag;
	}
	
	//修改任务taskNowId信息
	public void updateTaskData(String id,String value,String attribute){
		int taskId=Integer.parseInt(id);
		int result=-1;
		try{
			ct=new ConnDB().getConn();
			sql="update task set " + attribute + "='" + value + "' where taskId='" + taskId + "'";
			ps=ct.prepareStatement(sql);
			result=ps.executeUpdate();
			if(result>=1){
				System.out.println("修改成功！");
			}
			else{
				System.out.println("修改失败！");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
	}
	
	//获得查询数据库语句的结果
	public TaskBean[] queryTaskData(String personName){
 		TaskBean[] tb=new TaskBean[50];
		try{
			ct=new ConnDB().getConn();
			if(personName.contentEquals("all"))
				sql="select * from task";
			else
				sql="select * from task where taskPerson like '%" + personName + "%'";
			int i=0;
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				tb[i]=new TaskBean();
				if(rs.getString(1)!=null){
					tb[i].setTaskId(rs.getInt(1));
				}
				else{
					tb[i].setTaskId(0);
				}
				if(rs.getString(2)!=null){
					tb[i].setTaskName(rs.getString(2));
				}
				else{
					tb[i].setTaskName("");
				}
				if(rs.getString(3)!=null){
					tb[i].setTaskAmount(rs.getInt(3));
				}
				else{
					tb[i].setTaskAmount(0);
				}
				if(rs.getString(4)!=null){
					tb[i].setTaskPerson(rs.getString(4));
				}
				else{
					tb[i].setTaskPerson("");
				}
				if(rs.getString(5)!=null){
					tb[i].setTaskTable(rs.getString(5));
				}
				else{
					tb[i].setTaskTable("");
				}
				if(rs.getString(6)!=null){
					tb[i].setTaskStartId(rs.getString(6));
				}
				else{
					tb[i].setTaskStartId("");
				}
				if(rs.getString(7)!=null){
					tb[i].setTaskFinishId(rs.getString(7));
				}
				else{
					tb[i].setTaskFinishId("");
				}
				if(rs.getString(8)!=null){
					tb[i].setTaskNowId(rs.getString(8));
				}
				else{
					tb[i].setTaskNowId("");
				}
				if(rs.getString(9)!=null){
					tb[i].setTaskFlag(rs.getString(9));
				}
				else{
					tb[i].setTaskFlag("");
				}
				if(rs.getString(10)!=null){
					tb[i].setTaskDescribe(rs.getString(10));
				}
				else{
					tb[i].setTaskDescribe("");
				}
				if(rs.getString(11)!=null){
					tb[i].setTaskDetail(rs.getString(11));
				}
				else{
					tb[i].setTaskDetail("");
				}
				i++;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return tb;
	}
	//获得所有记录的数目
	/**
	 * 获得所有记录的数目
	 * @return 所有记录数目
	 */
	public int getDataNum(String personName){
		int rowCount=0;
		try{
			ct=new ConnDB().getConn();
			if(personName.equals("all"))
				sql="select count(*) from task";
			else
				sql="select count(*) from task where taskPerson like %" + personName + "%";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()){
				rowCount=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return rowCount;
	}

	//获得showDetails页中显示的邮票的id,从stamp表中获得
	/**
	 * 获得showDetails页中显示的邮票的id,从stamp表中获得
	 * @param stampShowNow 已显示的邮票id
	 * @return 将要显示的邮票信息字符串
	 */
	public String getGoods_Id(int countNow,String table,String mainKey){
		String id=null;
		try{
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement("select " + mainKey + " from " + table + " limit "+countNow+", 1");
			rs=ps.executeQuery();
			while(rs.next()){
				id=rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return id;
	}
	
	//获得showDetails页中显示的邮票的id,从stamp表中获得
	/**
	 * 获得showDetails页中显示的邮票的id,从stamp表中获得
	 * @param stampShowNow 已显示的邮票id
	 * @return 将要显示的邮票信息字符串
	 */
	public int getIndex(String taskId,String table,String mainKey){
		int index=0;
		try{
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement("select count(*) from " + table + " where " + mainKey + "<'" + taskId + "'");
			rs=ps.executeQuery();
			if(rs.next()){
				index=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return index;
	}
	
	//根据邮票id，得到详细信息
	/**
	 * 根据邮票id，得到详细信息
	 * @param id 邮票id
	 * @return GoodsBean对象
	 */
	public TaskBean getTaskBean(String id){
		
		TaskBean tb=new TaskBean();
		
		try{
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement("select * from task where taskId=?");
			ps.setString(1,id);
			rs=ps.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1)!=null){
					tb.setTaskId(rs.getInt(1));
				}
				else{
					tb.setTaskId(0);
				}
				if(rs.getString(2)!=null){
					tb.setTaskName(rs.getString(2));
				}
				else{
					tb.setTaskName("");
				}
				if(rs.getString(3)!=null){
					tb.setTaskAmount(rs.getInt(3));
				}
				else{
					tb.setTaskAmount(0);
				}
				if(rs.getString(4)!=null){
					tb.setTaskPerson(rs.getString(4));
				}
				else{
					tb.setTaskPerson("");
				}
				if(rs.getString(5)!=null){
					tb.setTaskTable(rs.getString(5));
				}
				else{
					tb.setTaskTable("");
				}
				if(rs.getString(6)!=null){
					tb.setTaskStartId(rs.getString(6));
				}
				else{
					tb.setTaskStartId("");
				}
				if(rs.getString(7)!=null){
					tb.setTaskFinishId(rs.getString(7));
				}
				else{
					tb.setTaskFinishId("");
				}
				if(rs.getString(8)!=null){
					tb.setTaskNowId(rs.getString(8));
				}
				else{
					tb.setTaskNowId("");
				}
				if(rs.getString(9)!=null){
					tb.setTaskFlag(rs.getString(9));
				}
				else{
					tb.setTaskFlag("");
				}
				if(rs.getString(10)!=null){
					tb.setTaskDescribe(rs.getString(10));
				}
				else{
					tb.setTaskDescribe("");
				}
				if(rs.getString(11)!=null){
					tb.setTaskDetail(rs.getString(11));
				}
				else{
					tb.setTaskDetail("");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//关闭资源
			this.close();
		}
		return tb;
	}
		
	//根据邮票id，得到详细信息
	/**
	 * 根据邮票id，得到详细信息
	 * @param id 邮票id
	 * @return GoodsBean对象
	 */
	public StampBean getStampBean(String id){
		
		StampBean sb=new StampBean();
		
		try{
			ct=new ConnDB().getConn();
			ps=ct.prepareStatement("select * from stamp where stampId=?");
			ps.setString(1,id);
			rs=ps.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1)!=null){
					sb.setStampId(rs.getString(1));
				}
				else{
					sb.setStampId("");
				}if(rs.getString(2)!=null){
					sb.setStampCountry(rs.getString(2));
				}
				else{
					sb.setStampCountry("");
				}
				if(rs.getString(3)!=null){
					sb.setStampYear(rs.getString(3));
				}
				else{
					sb.setStampYear("");
				}
				if(rs.getString(4)!=null){
					sb.setStampInGroupId(rs.getString(4));
				}
				else{
					sb.setStampInGroupId("");
				}
				if(rs.getString(5)!=null){
					sb.setStampPeriod(rs.getString(5));
				}
				else{
					sb.setStampPeriod("");
				}
				if(rs.getString(6)!=null){
					sb.setStampIdInPeriod(rs.getString(6));
				}
				else{
					sb.setStampIdInPeriod("");
				}
				if(rs.getString(7)!=null){
					sb.setStampIdInGroup(rs.getString(7));
				}
				else{
					sb.setStampIdInGroup("");
				}
				if(rs.getString(8)!=null){
					sb.setStampInGroupTitle(rs.getString(8));
				}
				else{
					sb.setStampInGroupTitle("");
				}
				if(rs.getString(9)!=null){
					sb.setStampTitle(rs.getString(9));
				}
				else{
					sb.setStampTitle("");
				}
				if(rs.getString(10)!=null){
					sb.setStampDate(rs.getInt(10));
				}
				else{
					sb.setStampDate(0);
				}
				if(rs.getString(11)!=null){
					sb.setStampType(rs.getString(11));
				}
				else{
					sb.setStampType("");
				}
				if(rs.getString(12)!=null){
					sb.setStampValue(rs.getString(12));
				}
				else{
					sb.setStampValue("");
				}
				if(rs.getString(13)!=null){
					sb.setStampSize(rs.getString(13));
				}
				else{
					sb.setStampSize("");
				}
				if(rs.getString(14)!=null){
					sb.setStampDesigner(rs.getString(14));
				}
				else{
					sb.setStampDesigner("");
				}
				if(rs.getString(15)!=null){
					sb.setStampPublisher(rs.getString(15));
				}
				else{
					sb.setStampPublisher("");
				}
				if(rs.getString(16)!=null){
					sb.setStampUrl(rs.getString(16));
				}
				else{
					sb.setStampUrl("");
				}
				if(rs.getString(17)!=null){
					sb.setStampLocalAddress(rs.getString(17));
				}
				else{
					sb.setStampLocalAddress("");
				}
				if(rs.getString(18)!=null){
					sb.setStampOthers(rs.getString(18));
				}
				else{
					sb.setStampOthers("");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//关闭资源
			this.close();
		}
		return sb;
	}
	
	//根据邮票id，得到详细信息
		/**
		 * 根据邮票id，得到详细信息
		 * @param id 邮票id
		 * @return GoodsBean对象
		 */
		public GroupsBean getGroupsBean(String id){
			
			GroupsBean gb=new GroupsBean();
			
			try{
				ct=new ConnDB().getConn();
				ps=ct.prepareStatement("select * from groups where groupId=?");
				ps.setString(1,id);
				rs=ps.executeQuery();
				
				if(rs.next()){
					if(rs.getString(1)!=null){
						gb.setGroupId(rs.getString(1));
					}
					else{
						gb.setGroupId("");
					}if(rs.getString(2)!=null){
						gb.setGroupCountry(rs.getString(2));
					}
					else{
						gb.setGroupCountry("");
					}
					if(rs.getString(3)!=null){
						gb.setGroupTitle(rs.getString(3));
					}
					else{
						gb.setGroupTitle("");
					}
					if(rs.getString(4)!=null){
						gb.setGroupTag(rs.getString(4));
					}
					else{
						gb.setGroupTag("");
					}
					if(rs.getString(5)!=null){
						gb.setGroupStampNum(rs.getInt(5));
					}
					else{
						gb.setGroupStampNum(0);
					}
					if(rs.getString(6)!=null){
						gb.setGroupFromDate(rs.getString(6));
					}
					else{
						gb.setGroupFromDate("");
					}
					if(rs.getString(7)!=null){
						gb.setGroupFinishDate(rs.getString(7));
					}
					else{
						gb.setGroupFinishDate("");
					}
					if(rs.getString(8)!=null){
						gb.setGroupOthers(rs.getString(8));
					}
					else{
						gb.setGroupOthers("");
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				//关闭资源
				this.close();
			}
			return gb;
		}
	
	//关闭函数
	/**
	 * 关闭函数，关闭数据库连接
	 */
	public void close(){
		try{
			
			if(rs!=null){
				rs.close();
				rs=null;
				
			}
			if(ps!=null){
				ps.close();
				ps=null;
			}
			if(!ct.isClosed()){
				ct.close();
				ct=null;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
