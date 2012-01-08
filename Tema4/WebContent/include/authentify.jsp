<%@page import="aii.Utilizator"%>
<%@page import="aii.Utilizator.Tip"%>
<%
	//After import, the logged in user, if any will be available
	Tip authenticationType=(Tip)request.getAttribute("permissions");
	Utilizator utilizator=(Utilizator)session.getAttribute("user");
	
	log("Verificam autentificarea pentru "+utilizator+" pentru "+authenticationType);
	if(authenticationType!=null)
	{
		//The user is not logged in
		if(utilizator==null)
		{
			response.sendRedirect("index.jsp");
			log("[ERROR] Lipsa utilizator in sesiune!");
			return;
		}
		//The user doesn't have the required permissions
		if(authenticationType!=Tip.ANY)
		{
			boolean fail=false;
			if(authenticationType==Tip.ADMIN && (utilizator.tip!=Tip.ADMIN && utilizator.tip!=Tip.SUPER_ADMIN) )
			{
				fail=true;
			}
			if(authenticationType==Tip.CADRU_DIDACTIC && (utilizator.tip!=Tip.CADRU_DIDACTIC && utilizator.tip!=Tip.SEF_CATEDRA) )
			{
				fail=true;
			}
			if(authenticationType==Tip.STUDENT && utilizator.tip!=Tip.STUDENT)
			{
				fail=true;
			}
			if(authenticationType==Tip.SECRETAR && utilizator.tip!=Tip.SECRETAR)
			{
				fail=true;
			}
			
			//The type was not the required one
			if(fail)
			{
				response.sendRedirect("index.jsp?error='Lipsa Permisiuni'");
				log("[ERROR] Utilizatorul nu are permisiunile necesare!");
			}
		}
	}
		
%>