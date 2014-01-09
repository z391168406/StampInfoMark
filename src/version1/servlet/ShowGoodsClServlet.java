package version1.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import version1.model.*;

/**
 * Servlet implementation class ShowGoodsClServlet
 */
public class ShowGoodsClServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowGoodsClServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		String table=request.getParameter("table");
		String taskId=request.getParameter("taskId");
		String taskNowId=request.getParameter("taskNowId");
		String taskFinishId=request.getParameter("taskFinishId");
		GoodsBeanBO gbb= new GoodsBeanBO();
		StampBean sb=new StampBean();
		GroupsBean gb=new GroupsBean();
	
		if("stamp".equals(table)){
			//得到显示的货物的id
			int stampStartId=gbb.getIndex(taskNowId, table, "stampId");
			int stampFinishId=gbb.getIndex(taskFinishId, table, "stampId");
 			if(stampStartId<=stampFinishId){
 				String goodsId=gbb.getGoods_Id(stampStartId,"stamp", "stampId");
 				sb=gbb.getStampBean(goodsId);
 				taskNowId=gbb.getGoods_Id(stampStartId+1,"stamp", "stampId");
 				gbb.updateTaskData(taskId, taskNowId, "taskNowId");
 				System.out.println(taskNowId);
 				request.setAttribute("goodInfo",sb);
				request.setAttribute("taskId",taskId);
				request.setAttribute("taskNowId",taskNowId);
				request.setAttribute("taskFinishId",taskFinishId);
				request.getRequestDispatcher("StampInfoModify.jsp").forward(request,response);
			}
			else{
				gbb.updateTaskData(taskId, "已完成", "taskFlag");
			}
		}
		else if("groups".equals(table)){
			System.out.println(taskNowId);
			int groupsStartId=gbb.getIndex(taskNowId, table, "groupId");
			int groupsFinishId=gbb.getIndex(taskFinishId, table, "groupId");
			if(groupsStartId<=groupsFinishId){
				String goodsId=gbb.getGoods_Id(groupsStartId,"groups", "groupId");
				gb=gbb.getGroupsBean(goodsId);
				taskNowId=gbb.getGoods_Id(groupsStartId+1,"groups", "groupId");
				gbb.updateTaskData(taskId,taskNowId,"taskNowId");
				System.out.println(taskNowId);
				request.setAttribute("goodInfo",gb);
				request.setAttribute("taskId",taskId);
				request.setAttribute("taskNowId",taskNowId);
				request.setAttribute("taskFinishId",taskFinishId);
				request.getRequestDispatcher("GroupsInfoModify.jsp").forward(request, response);
			}
			else{
				gbb.updateTaskData(taskId, "已完成", "taskFlag");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doGet(request, response);
		
	}

}
