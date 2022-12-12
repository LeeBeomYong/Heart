//팝업 위치를 지정(화면의 가운데 정렬)
var width = 500; //팝업의 너비
var height = 600; //팝업의 높이
var themeObj = {
    bgColor: "#ECECEC", //바탕 배경색
    searchBgColor: "#FFFFFF", //검색창 배경색
    contentBgColor: "#FFFFFF", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
    pageBgColor: "#FAFAFA", //페이지 배경색
    textColor: "#333333", //기본 글자색
    queryTextColor: "#222222", //검색창 글자색
    postcodeTextColor: "#FA4256", //우편번호 글자색
    emphTextColor: "#008BD3", //강조 글자색
    outlineColor: "#E0E0E0" //테두리
};

// 회원가입 다음 주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            width: width //생성자에 크기 값을 명시적으로 지정해야 합니다.
            height: height
            popupTitle : '우편주소 검색'
            autoClose: false

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;

            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();

        }
    }).open({
        left: (window.screen.width / 2) - (width / 2),
        top: (window.screen.height / 2) - (height / 2)
    });
}




$(function() {
	// 카카오 api 사용
	Kakao.init('b6f75c3aa40a005f012dbe14f5ac031e');
	Kakao.isInitialized();
	console.log(Kakao.isInitialized());
	
	// 카카오 로그인 api
	Kakao.Auth.createLoginButton({
	    container: '#kakao-login-btn',
	    success: function(authObj) {
	        Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(result) {
	                id = "K"+result.id
	                nickname = result.properties.nickname
	                kakao_account = result.kakao_account
	               
	                console.log('아이디 :'+id, '이름 :'+nickname);
	
	                $.ajax({
	                    type: "POST",
	                    contentType:  "application/x-www-form-urlencoded;charset=UTF-8",
	                    url: "/project/kakao_login",
	                    data: {
	                        paramId : id,
	                        paramName : nickname
	                    },
	                    dataType: "text",
	                    success: function(data) {
	                    	if(data != null) {
	                    		console.log("카카오 로그인 성공");
	                        	alert('로그인 되었습니다!');
	                        	window.location.reload();
	                    		
	                    	}else {
	                    		alert('로그인 실패ㅠ');
	                    	}
	                    },
	                    error: function(e) {
	                        console.log("ajax fail", e);
	                    }
	                });
	
	            },
	            fail: function(error) {
	                alert(
	                    'login success, but failed to request user information: ' +
	                    JSON.stringify(error)
	                );
	            }
	        });
	    },
	    fail: function(err) {
	        alert('failed to login: ' + JSON.stringify(err));
	    }
	});
	
	// 로그인 : 아이디 입력 ajax
	$("#login_id").keyup(function() {
		let id = $(this).val();	
		
		if(id == '') {
			$("#login_id").css({
				'border': '2px solid red',
				'border-radius': '3px'
			});
			$("#login_btn").attr("disabled", true);
			$("#idcheck").html("<i class='bi bi-x-circle-fill'></i><br><font style='color:red; font-size:13px;'>아이디를 입력하세요.</font>");
		}else {			
			$.ajax({			
	            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	            type: "POST",
	            url: "/project/id_check",
	            data: {paramId : id},
	            success: function(res) {
	            	if(res == 1) {  // DB에 아이디가 존재하는 경우
						$("#idcheck").html("<i class='bi bi-check-circle-fill'></i><br><font style='color:green; font-size:13px;'>아이디 확인 완료</font>");
						$("#login_id").css({
							'border': '2px solid green',
							'border-radius': '3px'
						});
						$("#login_btn").attr("disabled", false);
					}else {
						$("#idcheck").html("<i class='bi bi-x-circle-fill'></i><br><font style='color:red; font-size:13px;'>존재하지 않는 아이디입니다.</font>");
						$("#login_btn").attr("disabled", true);
						$("#login_id").css({
							'border': '2px solid red',
							'border-radius': '3px'
						});
						$("#login_btn").attr("disabled", true);
					}
	            },
	            error: function(e) {            
	                console.log("ajax fail", e);
	            }
	        });
		}
	});
	
  	// 회원가입 아이디
	$("#input_id").keyup(function() {
		let id = $(this).val();	
		
		let id_pattern = /^[a-z]+[a-zA-Z0-9]{4,20}$/;
		
		if(id == '') {
			console.log('아이디 공란');
			$("#join_id").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>  아이디 : 5자 이상 20자 이내 대소문자, 숫자 </font>");
			$("#input_id").css({
				'border-bottom': '2px solid red'
			});
			$("#join_btn").attr("disabled", true);
		}else {
			if(id_pattern.test(id)) {
				$.ajax({			
		            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		            type: "POST",
		            url: "/project/id_check",
		            data: {paramId : id},
		            success: function(res) {
		            	if(res == 1) {  // DB에 아이디가 존재하는 경우
		            		console.log('DB 존재 아이디');
							$("#join_id").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px;'> 존재하는 아이디입니다. 다시 만들어주세요. </font>");
							$("#input_id").css({
								'border-bottom': '2px solid red'
							});
							$("#join_btn").attr("disabled", true);
						}else {
							console.log('사용가능한 아이디');
							$("#join_id").html("<i class='bi bi-check-circle'></i><br><font style='color:green; font-size:13px;'> 사용가능한 아이디입니다.</font>");
							$("#join_btn").attr("disabled", false);
							$("#input_id").css({
								'border-bottom': '2px solid green'
							});
						}
		            },
		            error: function(e) {            
		                console.log("ajax fail", e);
		            }
		       	});
			}else {
				console.log('정규식 조건 위배 아이디');
				$("#join_id").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>  아이디 : 5자 이상 20자 이내 대소문자, 숫자 </font>");
				$("#input_id").css({
					'border-bottom': '2px solid red'
				});
				$("#join_btn").attr("disabled", true);
			}
		}
	});
	
	// 회원가입 비밀번호
  	$("#input_pwd").keyup(function() {
		let pwd = $(this).val();	
		
		let pwd_pattern = /^[a-zA-z0-9]{5,20}$/;
		
		if(pwd == '') {
			console.log('비밀번호 공란');
			$("#join_pwd").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>  비밀번호 : 5자 이상 20자 이내  </font>");
			$("#input_pwd").css({
				'border-bottom': '2px solid red'
			});
			$("#join_btn").attr("disabled", true);
		}else {
			if(pwd_pattern.test(pwd)) {
				console.log('사용가능한 비밀번호');
				$("#join_pwd").html("<i class='bi bi-check-circle'></i>");
				$("#join_btn").attr("disabled", false);
				$("#input_pwd").css({
					'border-bottom': '2px solid green'
				});
			}else {
				console.log('조건 위배 비밀번호');
				$("#join_pwd").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>  비밀번호 : 5자 이상 20자 이내 </font>");
				$("#input_pwd").css({
					'border-bottom': '2px solid red'
				});
				$("#join_btn").attr("disabled", true);
			}
		}
	});
	
	// 회원가입 이메일
	$("#input_email").keyup(function() {
		let email = $(this).val();
		
		let email_pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
		if(email == '') {
			$("#join_email").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>이메일 형식에 맞게 작성해주세요.</font>");
			$("#input_email").css({
				'border-bottom': '2px solid red'
			});
			$("#join_btn").attr("disabled", true);
		}else {
			if(email_pattern.test(email)) {
				$.ajax({			
		            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		            type: "POST",
		            url: "/project/email_check",
		            data: {email : email},
		            success: function(res) {
		            	if(res == 1) {  // DB에 이메일이 존재하는 경우
		            		console.log('DB 존재 이메일');
							$("#join_email").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px;'> 존재하는 이메일입니다.</font>");
							$("#input_email").css({
								'border-bottom': '2px solid red'
							});
							$("#join_btn").attr("disabled", true);
						}else {
							console.log('사용가능한 이메일');
							$("#join_email").html("<i class='bi bi-check-circle'></i><br><font style='color:green; font-size:13px;'> 사용가능한 이메일입니다.</font>");
							$("#join_btn").attr("disabled", false);
							$("#input_email").css({
								'border-bottom': '2px solid green'
							});
						}
		            },
		            error: function(e) {            
		                console.log("ajax fail", e);
		            }
		       	});
			}else {
				console.log('조건 위배 이메일');
				$("#join_email").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>이메일 형식에 맞게 입력해주세요.</font>");
				$("#input_email").css({
					'border-bottom': '2px solid red'
				});
				$("#join_btn").attr("disabled", true);
			}
		}
		
	});
	
	// 회원가입 연락처
	$("#input_phone").keyup(function() {
		
		let phone = $(this).val();
		
		if(phone == '') {
			console.log('연락처 공란');
			$("#join_phone").html("<i class='bi bi-exclamation-circle'></i><br><font style='color:red; font-size:13px'>연락처 ex) 010-0000-0000</font>");
			$("#input_phone").css({
				'border-bottom': '2px solid red'
			});
			$("#join_btn").attr("disabled", true);
		}else {
			$("#join_phone").html("<br><font style='color:darkgray; font-size:13px'>연락처 ex) 010-0000-0000</font>");
			$("#input_phone").css({
				'border-bottom': '2px solid black'
			});
			$("#join_btn").attr("disabled", false);
		}
		
	});
	
	
	let zipcode = $("#sample6_postcode").val();
	let address = $("#sample6_detailAddress").val();
	
	if(zipcode == '' || address == '') {
		$("#join_btn").attr("disabled", true);
	}
	
	
	
});


	var naver_id_login = new naver_id_login("fw7rzSQL46p95xisWWtm", "http://localhost:8081/project/naver_login");
	var state = naver_id_login.getUniqState();

	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain("http://localhost:8081/project/naver_login");
	naver_id_login.setState(state);
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
	
	console.log('네이버 버튼 생성');
	
	



