<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forum_main.aspx.cs" Inherits="forums_forum_main" %>
<%@ Import Namespace ="System.Data" %>
<%@ Import Namespace ="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta name="Description" content="eForum : : Forum for the Programmers, anything related to programming, technologies, security and logics." />
<meta name="Keywords" content="eForum : : Forum for the Programmers, anything related to programming, technologies, security and logics." />

<link href="../style/Style1.css" rel="stylesheet" type="text/css" />
    <title>eForum : : Forum for the Programmers, anything related to programming, technologies, security and logics.</title>
       <script language="javascript">
    	function click_link(url)
    	{
    		self.location=url;
    	}
    	function bgMOver(t)
		{
			t.background='../images/b2.gif';
		}
		function bgMOut(t )
		{
			
				t.background='../images/b1.gif';
			
		}
    	
    </script>
   
</head>
<body topmargin="0" leftmargin="0">
    <form id="form1" runat="server">
    

    <div align="center">
      <table border="0" width="993" cellspacing="0" cellpadding="0" height="413" bgcolor="#FFFFFF" id="table2">
        <tr>
          <td  bgcolor="#666666" width="5" rowspan="3" class="td3">
			</td>
          <td height="26" bgcolor="#999999" class ="td4" align="left" valign="top">
			<img border="0" src="images/top1.gif" width="988" height="90"></td>
        </tr>
        
        <tr>
          <td valign="top" align="left" height="323">
            <div align="left">
              <table border="0" width="100%" cellpadding="2" id="table4">
                <tr>
                  <td width="99%" colspan="2">
                    <table border="0" width="100%" cellspacing="0" id="table5" bgcolor="#000000">
						<tr>
							<td>
							<table border="0" width="100%" id="table6" bgcolor="#FFFFFF">
								<tr>
									<td>Welcome <b>
									<% 
									if( Session["login_success"] == "" || Session["login_success"] == null) 
									{
										Response.Write("Guest");
									}
									else
									{
										Response.Write(Session["display_name"].ToString());
									}
									%>
 									</b></td>
									<td align="right" width="420">
									<a href="forum_mythread.aspx">My Thread</a> | 
									<a href="forum_search.aspx">Search</a> | 
									<a href="forum_active_topics.aspx">Active Topics</a> | 
									<a href="forum_members.aspx">Members</a> |
									
									<%
									if( Session["login_success"] == "" || Session["login_success"] == null) 
									{
										Response.Write("<a href='../members/member_signin.aspx'>Log In</a> | <a href='../members/newmember.aspx'>Register</a>");
									}
									else
									{
									    	Response.Write("<a href='../members/member_signin.aspx'>Log Out</a>");
									}
									%>
									
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
                    
                    
                    
                    </td>
                </tr>
                <tr>
                  <td width="100%" colspan="2"><br>
					<a href="../default.aspx">eForum</a> <b>&gt;&gt; 
					
					<%
					    //Dim DPath As String
					    //DPath = Server.MapPath(".")
					    
					    SqlConnection Cn=new SqlConnection( ClsMain.ConnStr);
					    if (Cn.State ==ConnectionState.Closed ){ Cn.Open ();}
					    SqlCommand Com2 = new SqlCommand("select forum_name from forum_master where sno =" + Request.QueryString["forum_id"].ToString(), Cn);
					    Response.Write(Com2.ExecuteScalar().ToString());
					    if (Cn.State ==ConnectionState.Open ){ Cn.Close ();}
					
					 %>
					
<br>
					</b> <br>
					<br>
					<asp:Button ID="CmdNewTopics" runat="server" CssClass="TextBoxStyle" Text="New Topics"
                                            Width="72px" OnClick ="CmdNewTopics_Click" />
					<%
					
					if( Session["login_success"] == "" || Session["login_success"] == null) 
					{
						Response.Write("NOTE : Log In required to post new topic, questions.");
						CmdNewTopics.Visible=false;
					}
					else
					{
					
					}
					%>
                  </td>
                </tr>
                <tr>
                  <td width="100%" colspan="2">
					<table border="0" width="100%" cellspacing="0" bgcolor="#000000" id="table7">
						<tr>
							<td>
							<table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" id="table8">
								<tr>
									<td>
									<table border="1" width="942" cellspacing="1" id="table9" bordercolor="#E1E4F0">
										<tr>
											<td width="50" class="td6" height="34">
											<b>&nbsp;</b></td>
											<td width="307" class="td6" height="34" align="center">
											<b>Topics</b></td>
											<td width="139" class="td6" height="34" align="center">
											<p align="center"><b>Topic Starter</b></td>
											<td class="td6" height="34" width="59" align="center">
											<p align="center"><b>Replies</b></td>
											<td width="68" class="td6" height="34" align="center">
											<b>Views</b></td>
											<td width="292" class="td6" height="34" align="center">
											<b>Last Post</b></td>
										</tr>
										
										<%
										    //Dim DPath As String
										    //DPath = Server.MapPath(".")
										    //dim Cn As New Data.OleDb.OleDbConnection("provider=microsoft.jet.oledb.4.0; data source=" & DPath & "..\..\dbase\data.mdb")
                                            if (Cn.State == ConnectionState.Closed)
                                            {
                                                Cn.Open();
                                            }
										    SqlDataAdapter Da = new SqlDataAdapter(" select * from forum_topics where forum_id = " + Request.QueryString["forum_id"].ToString() +  " order by sno ", Cn);
					                          DataSet Ds = new DataSet();
					                          Da.Fill(Ds, "forum_topics");
                                              if (Ds.Tables["forum_topics"].Rows.Count > 0)
                                              {
                                                  int i;
                                                  for (i = 0; i <= Ds.Tables["forum_topics"].Rows.Count - 1; i++)
                                                  {
                                                      DataRow R;
                                                      R = Ds.Tables["forum_topics"].Rows[i];
                                                      Response.Write("<tr>");

                                                      String StrForumIcon;
                                                      StrForumIcon = "<img src=images/p2p_forum_old.gif alt='eForum Forum - Old and Active'>";
                                                      if (R["is_locked"].ToString() == "1")
                                                      {
                                                          StrForumIcon = "<img src=images/p2p_forum_old_lock.gif alt='eForum Forum - Currently this is locked'>";
                                                      }
                                                      SqlCommand Com = new SqlCommand();
                                                      Com = new SqlCommand("select count(*)  from forum_post where topic_id =" + R["sno"].ToString() + " ", Cn);
                                                      int QrRe;
                                                      QrRe = int.Parse(Com.ExecuteScalar().ToString());
                                                      if (QrRe == 0)
                                                      {
                                                          StrForumIcon = "<img src=images/p2p_forum_new.gif alt='eForum Forum - New Post'>";
                                                      }


                                                      //1
                                                      Response.Write("<td width='50' align='center'>" + StrForumIcon + "</td>");

                                                      //2
                                                      Response.Write("<td width='329'><b>");
                                                      Response.Write("<span style='font-weight: 700'>");
                                                      Response.Write("<a href='forum_topics.aspx?topic_id=" + R["sno"].ToString() + "'><span style='text-decoration: none'>" + R["topic_sub"].ToString() + "</span></a></td>");

                                                      //3
                                                      SqlDataAdapter Da1 = new SqlDataAdapter("select * from member_master where sno=" + R["mem_id"].ToString(), Cn);
                                                      DataSet Ds1 = new DataSet();
                                                      Da1.Fill(Ds1, "member_master");
                                                      String StrMemName;
                                                      StrMemName = Ds1.Tables["member_master"].Rows[0]["displayname"].ToString();

                                                      Response.Write("<td width='120' align='center'><a href=member_profile.aspx?id=" + R["mem_id"].ToString() + "><span style='text-decoration: none'>" + StrMemName + "</span></a></td>");

                                                      //4
                                                      Response.Write("<td>");
                                                      Response.Write("<p align='center'>" + R["total_replies"].ToString() + "</td>");

                                                      //5											
                                                      Response.Write("<td width='50'>");
                                                      Response.Write("<p align='center'>" + R["total_views"].ToString() + "</td>");

                                                      //6
                                                      //>>> get the last post deatils from 
                                                      Da1 = new SqlDataAdapter(" select * from forum_post where topic_id= " + R["sno"].ToString() + " order by sno desc ", Cn);
                                                      Ds1 = new DataSet();
                                                      Ds1.Clear();
                                                      Da1.Fill(Ds1, "post_master");

                                                      Response.Write("<td width='246'>");
                                                      if (Ds1.Tables["post_master"].Rows.Count > 0)
                                                      {
                                                          DataRow r1;
                                                          r1 = Ds1.Tables["post_master"].Rows[0];
                                                          Response.Write("<p align='center'><font size='1'>" + r1["post_date"].ToString() + "<br>");
                                                          //>>> get the last post
                                                          SqlDataAdapter da2 = new SqlDataAdapter("select * from member_master where sno =" + r1["mem_id"].ToString(), Cn);
                                                          DataSet Ds2 = new DataSet();
                                                          da2.Fill(Ds2, "member_master");
                                                          Response.Write(" by <b><a href=member_profile.aspx?id=" + r1["mem_id"].ToString() + ">" + Ds2.Tables["member_master"].Rows[0]["displayname"].ToString() + "</a></b> </font> ");
                                                      }
                                                      else
                                                      {
                                                          Response.Write("&nbsp;");
                                                      }


                                                      Response.Write("</td>");

                                                      Response.Write("</tr>");

                                                  }

                                              }
										%>
										
										

										
										
										
									</table>
									
									<p class="TextBoxStyle"><br>
&nbsp;<nobr> </nobr><br>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
                  </td>
                </tr>
                <tr>
                  <td width="100%" colspan="2">&nbsp;<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</td>
                </tr>
                <tr>
                  <td width="50%" valign="bottom"></td>
                  <td width="50%" valign="bottom">
                  
                  					<p align="right" class="TextBoxStyle"><br>
					
		
					
					
					</td>
    
                  
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>

      </table>C) eForum Version 1.0</div>
         
    </form>


</body>
</html>