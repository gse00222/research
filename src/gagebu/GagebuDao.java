package gagebu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GagebuDao {
	public Connection conn=null;
	public PreparedStatement pstmt=null;
	ResultSet rs=null;
	GagebuVo vo=null;
	
	String sql="";
	
	//생성자로 드라이버 연결 및 db연결
	public GagebuDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/works";
			String user="green";
			String pwd="1234";
			conn=DriverManager.getConnection(url, user, pwd);
			System.out.println("데이터베이스 연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패");
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스 연결 실패");
			e.printStackTrace();
		}
	}
	
	//데이터베이스 종료
	public void exit() {
		if(conn!=null) 
			try {
				conn.close();
			} catch (Exception e) {}
	}
	
	// statement객체 닫기메소드
	public void pstmtExit() {
		if(pstmt!=null)
			try {
				pstmt.close();
			} catch (Exception e) {}
	}
	//resultSet객체 닫기 메소드
	public void rsExit() {
		if(rs!=null)
			try {
				rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (Exception e) {}
	}

	
	//가계부 입력
	public void gInput(GagebuVo vo) {
		int balance;
		try {
			//기존의 잔고를 읽어온다
			sql="select balance from gagebu order by idx desc limit 1";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) balance=rs.getInt("balance");
			else balance=0;
			if(pstmt!=null) pstmt.close();
			//수입 혹은 지출 여부를 판단하여 잔액을 계산.
			if(vo.getGcode().equals("+")) balance+=vo.getPrice();
			else balance-=vo.getPrice(); 
			
			//입력된 자료를 가계부 테이블에 등록
			sql="insert into gagebu value (default,default,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getGcode());
			pstmt.setInt(2, vo.getPrice());
			pstmt.setString(3, vo.getContent());
			pstmt.setInt(4, balance);
			pstmt.executeUpdate();
			System.out.println("자료가 입력되었습니다.");
		} catch (SQLException e) {
			System.out.println("SQL구문 오류" +e.getMessage());
		} finally {
			try {
				pstmt.close();
				if(rs!=null) rs.close();
			} catch (Exception e) {}
		}
		
	}

	//전체 조회
//	public ArrayList<GagebuVo> gList() {
//		ArrayList<GagebuVo> vos=new ArrayList<GagebuVo>();
//		
//		try {
//			sql="select *from gagebu order by idx desc";
//			pstmt=conn.prepareCall(sql);
//			rs=pstmt.executeQuery();
//			
//			while(rs.next()) {
//				vo=new GagebuVo();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setWdate(rs.getString("wdate"));
//				vo.setGcode(rs.getString("gcode"));
//				vo.setPrice(rs.getInt("price"));
//				vo.setContent(rs.getString("content"));
//				vo.setBalance(rs.getInt("balance"));
//				vos.add(vo);
//			}
//			
//		} catch (SQLException e) {
//			System.out.println("SQL구문 오류" +e.getMessage());
//		} finally {
//			rsExit();
//		}
//		
//		return vos;
//		
//	}

	//개별 조회와 전체조회 한번에 하기.
	public ArrayList<GagebuVo> gSearch(String wdate) {
		ArrayList<GagebuVo> vos=new ArrayList<GagebuVo>();
		try {
			if(wdate.equals("list")) { //전체
				sql="select * from gagebu order by idx desc"; //SQL의 substr(변수,시작위치,꺼낼갯수)
				pstmt=conn.prepareCall(sql);
				rs=pstmt.executeQuery();
			} 
			else { //부분
				sql="select * from gagebu where replace(substr(wdate,1,10),'-','')=? order by idx desc"; //SQL의 substr(변수,시작위치,꺼낼갯수)
				pstmt=conn.prepareCall(sql);
				pstmt.setString(1, wdate);
				rs=pstmt.executeQuery();
			}
			while(rs.next()) {
				vo=new GagebuVo();
				vo.setIdx(rs.getInt("idx"));
				vo.setWdate(rs.getString("wdate"));
				vo.setGcode(rs.getString("gcode"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setBalance(rs.getInt("balance"));
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL구문 오류" +e.getMessage());
		} finally {
			rsExit();
		}
		return vos;
	}
	
	//db에서 실제 레코드 삭제
	public void gDelete(int idx) {
		try {
			//고유 번호 idx에 해당하는 gcode와 price를 읽어온다
			String gcode="";
			int price=0;
			sql="select gcode,price from gagebu where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				gcode=rs.getString("gcode");
				price=rs.getInt("price");
			}
			if(pstmt!=null) pstmt.close();
			//기존의 잔고중에서 마지막내역을 읽어온다
			int balance=0;
			sql="select idx,balance from gagebu order by idx desc limit 1";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				balance=rs.getInt("balance");
			}
			if(pstmt!=null) pstmt.close();
			//수입 혹은 지출 여부를 판단하여 잔액을 계산.
			if(gcode.equals("+")) balance-=price;
			else balance+=price; 
			
			sql="delete from gagebu where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			if(pstmt!=null) pstmt.close();
			
			sql="select idx,balance from gagebu order by idx desc limit 1";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				idx=rs.getInt("idx");
			}
			if(pstmt!=null) pstmt.close();
			
			sql="update gagebu set balance=? where idx=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, balance);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			pstmt.close();
			
			
			System.out.println("자료가 삭제되었습니다.");
		} catch (SQLException e) {
			System.out.println("SQL구문 오류" +e.getMessage());
		} finally {
			exit();
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
