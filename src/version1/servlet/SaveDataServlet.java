package version1.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import version1.model.*;
/**
 * Servlet implementation class SaveDataServlet
 */
public class SaveDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		PrintWriter out=response.getWriter();

		GoodsBeanBO gbb= new GoodsBeanBO();
		boolean flag_save=false;
		
		if("all".equals(request.getParameter("table"))){
			String id=request.getParameter("id");
			int stampDate=Integer.parseInt(request.getParameter("stampDate"));
			String stampTitle=new String(request.getParameter("stampTitle").getBytes("iso-8859-1"),"GBK");
			String stampType=new String(request.getParameter("stampType").getBytes("iso-8859-1"),"GBK");
			String stampValue=new String(request.getParameter("stampValue").getBytes("iso-8859-1"),"GBK");
			String stampSize=new String(request.getParameter("stampSize").getBytes("iso-8859-1"),"GBK");
			String stampDesigner=new String(request.getParameter("stampDesigner").getBytes("iso-8859-1"),"GBK");
			String stampPublisher=new String(request.getParameter("stampPublisher").getBytes("iso-8859-1"),"GBK");
			String groupTag=new String(request.getParameter("groupTag").getBytes("iso-8859-1"),"GBK");
			int groupNum=Integer.parseInt(request.getParameter("groupNum"));
			String groupFromDate=new String(request.getParameter("groupFromDate").getBytes("iso-8859-1"),"GBK");
			String groupFinishDate=new String(request.getParameter("groupFinishDate").getBytes("iso-8859-1"),"GBK");
			
			flag_save=gbb.saveAllData(id, stampDate, stampTitle,stampType,stampValue,stampSize,stampDesigner,stampPublisher,groupTag,groupNum,groupFromDate,groupFinishDate);
		}
		else if("task".contentEquals(request.getParameter("table"))){
			int taskId=Integer.parseInt(request.getParameter("taskId"));
			String taskName=new String(request.getParameter("taskName").getBytes("iso-8859-1"),"GBK");
			int taskAmount=Integer.parseInt(request.getParameter("taskAmount"));
			String taskPerson=new String(request.getParameter("taskPerson").getBytes("iso-8859-1"),"GBK");
			String taskTable=new String(request.getParameter("taskTable").getBytes("iso-8859-1"),"GBK");
			String taskStartId=new String(request.getParameter("taskStartId").getBytes("iso-8859-1"),"GBK");
			String taskFinishId=new String(request.getParameter("taskFinishId").getBytes("iso-8859-1"),"GBK");
			String taskNowId=new String(request.getParameter("taskNowId").getBytes("iso-8859-1"),"GBK");
			String taskFlag=new String(request.getParameter("taskFlag").getBytes("iso-8859-1"),"GBK");
			String taskDescribe=new String(request.getParameter("taskDescribe").getBytes("iso-8859-1"),"GBK");
			String taskDetail=new String(request.getParameter("taskDetail").getBytes("iso-8859-1"),"GBK");
			flag_save=gbb.saveTaskData(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskNowId,taskFlag,taskDescribe,taskDetail);
		}
		else if("stamp".contentEquals(request.getParameter("table"))){
			String stampId=new String(request.getParameter("stampId").getBytes("iso-8859-1"),"GBK");
			String stampInGroupTitle=new String(request.getParameter("stampInGroupTitle").getBytes("iso-8859-1"),"GBK");
			int stampDate=Integer.parseInt(request.getParameter("stampDate"));
			String stampTitle=new String(request.getParameter("stampTitle").getBytes("iso-8859-1"),"GBK");
			String stampType=new String(request.getParameter("stampType").getBytes("iso-8859-1"),"GBK");
			String stampValue=new String(request.getParameter("stampValue").getBytes("iso-8859-1"),"GBK");
			String stampSize=new String(request.getParameter("stampSize").getBytes("iso-8859-1"),"GBK");
			String stampDesigner=new String(request.getParameter("stampDesigner").getBytes("iso-8859-1"),"GBK");
			String stampPublisher=new String(request.getParameter("stampPublisher").getBytes("iso-8859-1"),"GBK");
			flag_save=gbb.saveStampData(stampId,stampInGroupTitle,stampDate,stampTitle,stampType,stampValue,stampSize,stampDesigner,stampPublisher);
		}
		else if("groups".contentEquals(request.getParameter("table"))){
			String groupId = new String(request.getParameter("groupId").getBytes("iso-8859-1"),"GBK");;
			String groupTitle = new String(request.getParameter("groupTitle").getBytes("iso-8859-1"),"GBK");
			String groupTag = new String(request.getParameter("groupTag").getBytes("iso-8859-1"),"GBK");
			int groupStampNum = Integer.parseInt(request.getParameter("groupStampNum"));
			String groupFromDate = new String(request.getParameter("groupFromDate").getBytes("iso-8859-1"),"GBK");
			String groupFinishDate = new String(request.getParameter("groupFinishDate").getBytes("iso-8859-1"),"GBK");
			flag_save=gbb.saveGroupsData(groupId,groupTitle,groupTag,groupStampNum,groupFromDate,groupFinishDate);
		}

		System.out.println(flag_save);
		
		if(flag_save==true){
			out.print("true");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

}
