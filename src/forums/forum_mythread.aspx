<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forum_mythread.aspx.cs" Inherits="forums_forum_mythread" %>
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
      <table border="0" width="993" cellspacing="0" cellpadding="0" height="423" bgcolor="#FFFFFF" id="table2">
        <tr>
          <td  bgcolor="#666666" width="5" rowspan="3" class="td3">
			</td>
          <td height="26" bgcolor="#999999" class ="td4" align="left" valign="top">
			<img border="0" src="images/top1.gif" width="988" height="90"></td>
        </tr>
        
        <tr>
          <td valign="top" align="left" height="333">
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
									if (Session["login_success"] == "" || Session["login_success"] ==null) 
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
									if (Session["login_success"] == "" || Session["login_success"] ==null) 
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
					<a href="../default.aspx">eForum</a><b>&nbsp; &gt;&gt; My Thread
					

					
<br>
					</b> <br>
					<br>
					<%
					if (Session["login_success"] == "" || Session["login_success"] ==null) 
                    {
					        Response.Write("<font color='red'>NOTE : Log In required to view thread you have careted.</font>");
						
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
									<table border="1" width="951" cellspacing="1" id="table9" bordercolor="#E1E4F0">
										<tr>
											<td width="50" class="td6" height="34">
											<b>&nbsp;</b></td>
											<td width="307" class="td6" height="34" align="center">
											<b>Topics</b></td>
											<td width="139" class="td6" height="34" align="center">
											<p align="center"><b>Forum</b></td>
											<td class="td6" height="34" width="73" align="center">
											<p align="center"><b>Replies</b></td>
											<td width="68" class="td6" height="34" align="center">
											<b>Views</b></td>
											<td width="285" class="td6" height="34" align="center">
											<b>Last Post</b></td>
										</tr>
										
										<%
										    SqlConnection Cn=new SqlConnection( ClsMain.ConnStr);
										    int MemId =0;
										    if (Session["login_success"] == "" || Session["login_success"] ==null) 
                                            {
                                            }
										       
										    else
                                            {
										        MemId = int.Parse((Session["mem_id"].ToString()));
										    }
										    int RowCount = 0;

										    SqlDataAdapter Da = new SqlDataAdapter(" select * from forum_topics where mem_id = " + MemId.ToString() + " order by sno ", Cn);
										    DataSet Ds = new DataSet();
										    Da.Fill(Ds, "forum_topics");
										    RowCount = Ds.Tables["forum_topics"].Rows.Count;
										    if (Ds.Tables["forum_topics"].Rows.Count > 0 )
                                            {
										        
                                                if(Cn.State == ConnectionState.Closed ){Cn.Open ();}
										        int i ;
										        for (i = 0;i<= Ds.Tables["forum_topics"].Rows.Count - 1;i++)
                                                {
										            DataRow R ;
										            R = Ds.Tables["forum_topics"].Rows[i];
										            Response.Write("<tr>");
										            
										            String StrForumIcon ;
										            StrForumIcon = "<img src=images/p2p_forum_old.gif alt='eForum Forum - Old and Active'>";
										            if (R["is_locked"].ToString() == "1" )
                                                    {
										                StrForumIcon = "<img src=images/p2p_forum_old_lock.gif alt='eForum Forum - Currently this is locked'>";
										            }
										            SqlCommand Com ;
										            Com = new SqlCommand("select count(*)  from forum_post where topic_id =" + R["sno"].ToString() , Cn);
										            int QrRe ;
										            QrRe = int.Parse ( Com.ExecuteScalar().ToString());
										            if (QrRe == 0 )
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
										            SqlDataAdapter Da1 = new SqlDataAdapter("select * from forum_master where sno=" + R["forum_id"].ToString(), Cn);
										            DataSet Ds1 = new DataSet();
										            Da1.Fill(Ds1, "forum_master");
										            String StrMemName  = "";
										            String StrForumName ;
										            StrForumName = Ds1.Tables["forum_master"].Rows[0]["forum_name"].ToString();
										            
										            Response.Write("<td width='120' align='center'><a href=forum_main.aspx?forum_id=" + R["forum_id"].ToString() + "><span style='text-decoration: none'>" + StrForumName + "</span></a></td>");
																										
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
										            if (Ds1.Tables["post_master"].Rows.Count > 0 )
                                                    {
										                DataRow r1 ;
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
									
									<%
									    int X;
									    X = RowCount;
									    if( RowCount < 5)
                                        {
									        X = 5 - RowCount;
                                        }
									    else
                                        {
									        X = 5;
										       
									    }
									    int j ;
                                        for (j = 1; j <= X * 2; j++)
                                        {
                                            Response.Write("<br>");
                                        }
									
									 %>
									
									<p class="TextBoxStyle"><br>
&nbsp; <nobr>Show Topics&nbsp; <select id="ctl00_Main_forum_ctl00_ShowList" onchange="javascript:setTimeout('__doPostBack(\'ctl00$Main$forum$ctl00$ShowList\',\'\')', 0)" name="ctl00$Main$forum$ctl00$ShowList">
									<option value="0">All</option>
									<option value="1">from the last day</option>
									<option value="2">from the last two days
									</option>
									<option value="3">from the last week
									</option>
									<option value="4">from the last two weeks
									</option>
									<option value="5">from the last month
									</option>
									<option value="6" selected>from the last two 
									months</option>
									<option value="7">from the last six months
									</option>
									</select> </nobr><br>
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
                  <td width="50%" valign="bottom">></td>
                  <td width="50%" valign="bottom">
                  
                  					<p align="right" class="TextBoxStyle"><br>
					
		
					
					
					</td>
    
                  
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>

      </table>
      (C) eForum Version 1.0</div>
         
    </form>


</body>
</html>
