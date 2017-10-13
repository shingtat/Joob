<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.chat" %>
<%@ page import="data.StringConstants" %>
<%@ page import="database.MySQLDriver" %>
<html>
<% 
	String type = (String)session.getAttribute("user_type");
	String myName = (String)session.getAttribute("logged_in_user");
	MySQLDriver server = (MySQLDriver)session.getAttribute("sqldriver");
	
%>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
<script src="../js/chatPage.js" type="text/javascript"></script>
<title>chat</title>
</head>
<body>

		<div id="navbar">
				  <div class="container-fluid">
				    <div id="profile">
				    	<form name="profile" action="${pageContext.request.contextPath}<%=StringConstants.ProfileServlet%>">
				    		<span onclick="document.profile.submit();">profile</span>
				    	</form>
			      	</div>
			      	<div id="search">
				      	<a href="jsp/<%=StringConstants.searchPage%>" style="text-decoration:none">
				      		<h2>search</h2>
						</a>
			      	</div>
			      	<div id="logout">
			      		<a href="jsp/<%=StringConstants.loginPage%>" style="text-decoration:none">
				        	<h3>log out</h3>
			        	</a>
			      	</div>
				  </div>
			</div>
		<div id="discussion board">
			<div id="board">
			</div>
			<input type="text" name="boardMessage" id = "boardMessage">
			<button type="button" onclick="post('<%=myName%>')">Submit to MessageBoard</button>
		</div>
		
		<table>
			<tbody>
				<%
				if (type.equals("Student"))
				{
					for (String username : server.getStudentMatchUsernames(myName)){
				%>
						<tr>
						<td><button type="button" onclick="saveName('<%=username%>','<%=type%>')"><%=username %></button></td>
					</tr>
					<%
					}
				}
				else
				{
					for (String username : server.getEmployerMatchUsernames(myName))
					{
				%>
								<tr>
								<td><button type="button" onclick="saveName('<%=username%>','<%=type%>')"><%=username %></button></td>
							</tr>
				<% 
					}
				}
				%>
			</tbody>
		</table>
		<div id="chatHistory">
			<p id="History"></p>
				<input type="text" name="mes" id = "message">
				<input type="submit" value="Send" onclick="sendMessage('<%=myName%>','<%=type%>')">
		</div>
</body>

</html>