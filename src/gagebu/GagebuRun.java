package gagebu;

import java.util.Scanner;

public class GagebuRun {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		GagebuService gagebuService=new GagebuService();
		GagebuDao dao=new GagebuDao();
		
		boolean run=true;
		
		System.out.println("==================가계부 프로그램(V1.58)======================");
		while(run) {
			System.out.println("---------------------------------------------------------");
			System.out.println("작업 선택 - 1.입력 2.날짜조회 3.전체조회 4.수정 5.삭제 0종료");
			System.out.println("---------------------------------------------------------");
			System.out.print("==>");
			int selNo=sc.nextInt();
			
			switch(selNo) {
				case 1 : //자료입력
					gagebuService.gInput();
					break;
				case 2 : //날짜조회
					gagebuService.gList(selNo);
					break;
				case 3 : //전체조회
					gagebuService.gList(selNo);
					break;
				case 4 : //수정
					//gagebuService.gUpdate();
					break;
				case 5 : //삭제
					gagebuService.gDelete();
					break;
				default : //종료
					run=false;
					break;
			}
			
		}
		System.out.println("=========================================================");
		System.out.println("==========================작업 끝==========================");
		System.out.println("=========================================================");
		dao.exit();
		sc.close();
	}
}
