<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.koreait.admin.product.ProductDTO" %>
<jsp:useBean id="dao" class="com.koreait.admin.product.ProductDAO"/>
<jsp:useBean id="dto" class="com.koreait.admin.product.ProductDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	int totalCount = 0;
	int pagePerCount = 10;
	int start = 0;
	
	String pro_search = request.getParameter("pro_search");
	String searchPro = request.getParameter("searchPro");
	String pageNum = request.getParameter("pageNum");
	if(pageNum != null && !pageNum.equals("")){
		start = (Integer.parseInt(pageNum)-1) * pagePerCount;
	}else{
		pageNum = "1";
		start = 0;
	}
	
	totalCount = dao.page();
	
	List<ProductDTO> proList = dao.searchProduct(pro_search, searchPro);
	
	String proCnt = "";
	

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체회원관리 - 사용자관리 | 관리자페이지</title>
    <link href="../css/templete.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
    <div id="container">
        <div class="sidebar">
            <ul>
                <li>
                    사용자관리
                    <ul>
                        <li><a href="../member/mem_manage.jsp">- 전체회원관리</a></li>
                        <li><a href="../member/mem_withdrawal.jsp">- 탈퇴신청회원관리</a></li>
                        <li><a href="../member/mem_block.jsp">- 계정차단회원관리</a></li>
                        <li><a href="../member/mem_reported.jsp">- 신고회원관리</a></li>
                    </ul>
                </li>
                <li>
                    상품관리
                    <ul>
                        <li class="title"><a href="../product/product_list.jsp">- 상품목록</a></li>
                        <li><a href="../product/payment_list.jsp">- 결제내역</a></li>
                    </ul>
                </li>
                <li><a href="../category.jsp">카테고리관리</a></li>
                <li>
                    게시판
                    <ul>
                        <li ><a href="../notice/notice_list.jsp">- 공지사항</a></li>
                        <li><a href="../notice/FAQ_list.jsp">- 자주묻는질문</a></li>
                    </ul>
                </li>
                <li><a href="../inquiry/inquiry_list.jsp">문의내역</a></li>
            </ul>
        </div>
        <div class="contents">
            <h1><img src="../images/arrow.png">상품목록</h1>
            
            <div class="product_list">
                <div class="product_search">
                    <table>
                        <form method="post" action="./product_list_search.jsp">
                        <tr>
                            <th><select name="pro_search">
                               <option value="상품명">상품명</option>
                               <option value="상점명">상점명</option>
                           </select></th>
   								
                            <td><input type="text" name="searchPro"/></td>
                            <td><input type="submit" value="검색"></td>
                        </tr>
                         </form>
                    </table>
                    <table>
                        <tr>
                            <td>선택된 상품을
                                <select name="pro_status">
                                    <option value="상품삭제">상품삭제</option>
                                    <option value="판매중">판매중</option>
                                    <option value="예약중">예약중</option>
                                    <option value="판매완료">판매완료</option>
                                </select>
                                <input type="button" value="처리">
                            </td>
                            <td>
                                <p>선택된 상품 총 <%=proList.size()%>개 | 총 등록상품 <%=proList.size()%>개</p>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="product_lists">
                    <div id="lists1">
                        <table>
                            <tr>
                                <th colspan="2">상품정보</th>
                                <th>판매상태</th>
                            </tr>
<%
						for(int i=0; i<proList.size(); i++){
							proList.get(i);
%>                     <tr>
                                <th><a href="./product_detail.jsp?p_idx=<%=proList.get(i).getIdx()%>"><img src='../uploads/<%=proList.get(i).getPicture()%>' width="100" alt="상품이미지"></a></th>
                                <td><span class="bold"><a href="./product_detail.jsp?p_idx=<%=proList.get(i).getIdx()%>"><%=proList.get(i).getName() %></a></span><br><%= proList.get(i).getPrice() %>원
                                <br>
<%
							String cate1 = dao.getCate1(proList.get(i).getCategory());
							String cate2 = dao.getCate2(proList.get(i).getCategory());
							String cate3 = dao.getCate3(proList.get(i).getCategory());
							String seller = dao.getSeller(proList.get(i).getMemidx());
%> 
									<%=cate1 %> > <%=cate2 %> > <%=cate3 %>
									<br>판매자 : <%=seller %></td>
                                <td><%=proList.get(i).getSalesStatus()%></td>
                            </tr>
                            <%
						}
                            %>
                        </table>
                    </div>
                   
                </div>
            </div>
            <p class="pageNum">  
			</p>
        </div>
    </div>
</body>
</html>