package version1.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;

import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;




import sun.misc.*;

import java.security.*;

import java.util.LinkedList;
import java.util.List;

/**
 * Servlet implementation class loginClServlet
 */
public class loginClServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginClServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();
		String email=request.getParameter("email")+"@software.nju.edu.cn";
		String password=request.getParameter("password");
		
		
		String encodedPassword=null;
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			byte[] b = md.digest();
			encodedPassword=(new BASE64Encoder()).encode(b);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		 System.out.println(encodedPassword);
		//向目的服务器发送请求
		 String data="<?xml version=\"1.0\" encoding=\"UTF-8\"?><auth><email>"+email+"</email><password>"+encodedPassword+"</password></auth>";
		 String url="http://software.nju.edu.cn:8000/api/auth/user/";
		 System.out.println(data);
		 String msg=null;
		 
		 try{
			 HttpPost httppost = new HttpPost(url);
			 HttpClient httpClient=new DefaultHttpClient();
			 List<BasicNameValuePair> params = new LinkedList<BasicNameValuePair>();
			 params.add(new BasicNameValuePair("fromdata", data));
			 httppost.setEntity(new UrlEncodedFormEntity(params, "utf-8"));
			 HttpResponse rs = httpClient.execute(httppost);
			 String info=EntityUtils.toString(rs.getEntity());
			 System.out.println(info);
             if(info.contains(">0<")){
            	 if("mf1332091@software.nju.edu.cn".contentEquals(email)){
	            	 Cookie cookie=new Cookie("email",email);
	            	 cookie.setMaxAge(14*24*3600);
	            	 response.addCookie(cookie);
	            	 request.setAttribute("username",email);
	            	 response.sendRedirect("admin.jsp");
//	            	 request.getRequestDispatcher("admin.jsp").forward(request, response);
            	 }
            	 else{
            		 Cookie cookie=new Cookie("email",email);
	            	 cookie.setMaxAge(14*24*3600);
	            	 response.addCookie(cookie);
	            	 request.setAttribute("username",email);
	            	 response.sendRedirect("user.jsp");
//	            	 request.getRequestDispatcher("user.jsp").forward(request, response);
            	 }
             }else{
            	 response.sendRedirect("loginFault.jsp");
             }
		 }
		 catch(Exception e){
			 
			 e.printStackTrace();
		 }
		
	}
	
	
}
