package gagebu;

import java.util.ArrayList;
import java.util.Scanner;

public class GagebuService {
	Scanner sc=new Scanner(System.in);
	GagebuVo vo=new GagebuVo();
	GagebuDao dao=new GagebuDao();
	
	//가계부 입력처리
	public void gInput() {
		while(true) {
			System.out.print("작업 선택 - 1.수입  2.지출  0.종료  ==>");
			String selNo=sc.next();
			if(selNo.equals("0"))break;
			
			if(selNo.equals("1")) vo.setGcode("+");
			if(selNo.equals("2")) vo.setGcode("-");
			
			System.out.print("금액 : "); vo.setPrice(sc.nextInt());
			System.out.print("내역 : "); vo.setContent(sc.next());
			
			dao.gInput(vo);
		}
		
	}
	
	//전체 및 개별조회
	public void gList(int selNo) {
		ArrayList<GagebuVo> vos=new ArrayList<GagebuVo>();
		String gcode="";
		String wdate="";
		if(selNo==2) {
			System.out.print("검색할 날짜를 입력하세요(예:20210412) ==>");
			wdate=sc.next();
			vos=dao.gSearch(wdate);
		}
		if(selNo==3) {
			vos=dao.gSearch("list");
		}
		//int balance=vos.get(0).getBalance();
		int balance=0, sw=0, suip=0, jichul=0; 
		
		System.out.println("=========================================================");
		System.out.println("거래 날짜 \t\t 비고 \t 금액 \t 내용");
		System.out.println("---------------------------------------------------------");
		for(GagebuVo vo:vos) {
			if(sw==0) {
				balance=vo.getBalance();
				sw=1;
			}
			if(vo.getGcode().equals("+")) {
				gcode="수입";
				suip+=vo.getPrice();
			}
			else {
				gcode="지출";
				jichul=vo.getPrice();
			}
			System.out.println(vo.getWdate().substring(0, 10)+"\t "+gcode+"\t"+String.format("%,7d", vo.getPrice())+"\t "+vo.getContent());
		}
		System.out.println("=========================================================");
		if(selNo==2) System.out.println("검색일자 : "+wdate+" , 수입 : "+suip+" , 지출 : "+jichul);
		System.out.println("현재 총 잔액 : "+String.format("%,7d",balance));
		System.out.println("---------------------------------------------------------");
	}

	//삭제
	public void gDelete() {
		ArrayList<GagebuVo> vos=new ArrayList<GagebuVo>();
		String gcode="";
		String wdate="";
		
		System.out.print("검색할 날짜를 입력하세요(예:20210412) ==>");
		wdate=sc.next();
		vos=dao.gSearch(wdate);
		
		System.out.println("=========================================================");
		System.out.println("고유번호\t거래 날짜 \t\t 비고 \t 금액 \t 내용");
		System.out.println("---------------------------------------------------------");
		for(GagebuVo vo:vos) {
			if(vo.getGcode().equals("+")) {
				gcode="수입";
			}
			else {
				gcode="지출";
			}
			System.out.println(vo.getIdx()+"\t"+vo.getWdate().substring(0, 10)+"\t "+gcode+"\t"+String.format("%,7d", vo.getPrice())+"\t "+vo.getContent());
		}
		System.out.println("=========================================================");
		System.out.print("삭제할 고유번호를 입력하세요 (종료:0)");
		int idx=sc.nextInt();
		if(idx==0)return;
		dao.gDelete(idx);
	}

	
	
	
	
	
	
	
}
