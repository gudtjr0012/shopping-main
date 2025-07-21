#  패션 쇼핑몰 앱 Hellfit 
Hell팀의 공동작업자 김형석, 김경현의 첫번째 프로젝트 입니다.  
패션 쇼핑몰 서비스를 **Flutter**로 구현했습니다.  
상품 리스트, 상세, 장바구니, 회원정보, 검색 등 실제 커머스에서 필요한 전 기능을  
커스텀 컴포넌트와 상태관리 없이 오로지 위젯 트리 구조로 구현했습니다.

---

##  주요 기능 요약

| 기능명         | 설명                                                                 |
| :------------- | :------------------------------------------------------------------- |
| **홈/카테고리** | 카테고리별 상품 리스트 진입 가능, 각 카테고리별 상품 탐색                |
| **상품 리스트** | 카테고리/핏 별 상품 목록, FAB(장바구니) 알림 뱃지 표시                  |
| **상품 상세**   | 컬러/사이즈/프린팅 옵션 선택, 장바구니 담기 및 즉시 구매, 하단 장바구니 바로가기 |
| **장바구니**   | 담은 상품 목록, 수량 조절 및 삭제, 전체 주문, 주문내역 팝업             |
| **My페이지**   | 신체정보/체형/사이즈 입력, AI 맞춤 핏 추천(기본 로직)                   |
| **피드(추천)** | 그리드 이미지 피드(브랜드/룩북 스타일 참고용)                          |
| **검색**       | 상단 입력창을 통한 상품명, 브랜드명 검색 (입력 필드 포함)                |
| **네비게이션** | 앱 하단 BottomNavigationBar를 통한 페이지 전환 및 탭 기록 기반 "이전탭" 뒤로가기 |

---

##  협업 및 설계 특징

- **Props & Callback 기반 컴포넌트 구조**  
  단일 상태관리 없이 각 Screen에 필요한 콜백(예: `onBack`, `addToCart` 등)과 데이터를 명확히 전달
- **FAB 통한 바로가기 & 이전페이지 유지**  
  상품상세, 상품리스트, 장바구니 화면 모두 FAB/뒤로가기 버튼 동작을 수동 제어 →  
  장바구니 진입 이후 뒤로가기시 원래 상세/리스트로 자연스럽게 이동
- **깃 브랜치 협업/병합 및 충돌 관리**  
  실제 개발환경처럼 동업자와 브랜치 활용 및 병합, 코드 충돌 해결

---

##  주요 폴더 구조 예시

<pre> <strong>프로젝트 폴더 구조</strong> <code> 
  lib/ ├── screens/ │ 
         ├── home_screen.dart │ 
         ├── product_list_page.dart │
         ├── product_detail_screen.dart │
         ├── cart_screen.dart │
         ├── feed_screen.dart │
         ├── my_screen.dart │
         └── search_screen.dart
        ├── main.dart 
  assets/
    └── images/ </code> </pre>


##  앱 구동 화면

<img width="346" height="755" alt="스크린샷 2025-07-21 오후 6 06 39" src="https://github.com/user-attachments/assets/c5bd4bf5-08fb-403a-93f4-b7462e4a21c1" />  
<img width="345" height="754" alt="스크린샷 2025-07-21 오후 6 06 58" src="https://github.com/user-attachments/assets/2e813af9-1662-4ed7-8906-12bd8c78618f" />
<img width="344" height="753" alt="스크린샷 2025-07-21 오후 6 07 18" src="https://github.com/user-attachments/assets/5344f91d-b631-43ab-89c8-dec1c86d440d" />  
<img width="344" height="758" alt="스크린샷 2025-07-21 오후 6 09 03" src="https://github.com/user-attachments/assets/3f0a6104-7290-4eb4-a1b8-fec15a52ad6f" />
<img width="345" height="752" alt="스크린샷 2025-07-21 오후 6 07 54" src="https://github.com/user-attachments/assets/2123dc19-848a-4290-aa08-dfe16faa3ba9" />  
<img width="345" height="752" alt="스크린샷 2025-07-21 오후 6 09 22" src="https://github.com/user-attachments/assets/284a942f-2f51-4e73-99d9-5edb1ea97fdb" />



