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
public class QueryDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryDataServlet() {
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
		TaskBean[] tb=new TaskBean[50];
		for(int i=0;i<50;i++){
			tb[i]=new TaskBean();
		}
		
		String type=new String(request.getParameter("type").getBytes("iso-8859-1"),"GBK");
		if(type.equals("all"))
			tb=gbb.queryTaskData("all");
		else
			tb=gbb.queryTaskData(type);
		tb[1].getTaskDescribe();
		request.setAttribute("taskInfo",tb[1]);
		request.getRequestDispatcher("admin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

}

