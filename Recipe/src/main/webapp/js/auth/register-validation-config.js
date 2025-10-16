/**
 *
 */
$.validator.addMethod("pwRule", function(value, element) {
  if (value === "") return true; // 입력 안 했으면 통과
    return /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d!@#$%^&*]{6,15}$/.test(value);
}, "＊비밀번호는 영문자와 숫자를 포함하여야합니다.");
  
$("#addForm").validate({
  rules: {
    // 유효성 검사 규칙
    password: {       // 비밀번호 필드
      required: true, // 필수 입력
      minlength: 6,   // 최소 입력 길이
      maxlength: 15, // 최대입력길이
      pwRule : true,
    },
    repassword: {  // 비밀번호 재확인 필드
      required: true,    // 필수 입력
      minlength: 6,      // 최소 입력 길이,
      maxlength: 15, // 최대입력길이
      equalTo: password, // 비밀번호 필드와 동일한 값을 가지도록
    },
    userName: {       // 유저이름
      required: true, // 필수 입력
      minlength: 2,   // 최소 입력 길이
    },
    email: {           // 이메일 필드
      required: true,  // 필수 입력
      email: true,     // 이메일 형식 검증
    },
    phoneNum: {
      // 연락처 필드
      required: true,  // 필수 입력
      digits: true,    // 숫자 형태로만 입력 가능하도록 설정
      maxlength: 15,
    }
  },
  messages: {
    // 오류값 발생시 출력할 메시지 수동 지정
      password: {
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
      maxlength: "＊최대 {0}글자 이하 입력하세요.",
    },
      repassword: {
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
      maxlength: "＊최대 {0}글자 이하 입력하세요.",
      equalTo: "＊동일한 비밀번호를 입력해 주세요.",
    },
      userName: {   // 사용자이름
      required: "＊필수 입력 항목입니다.",
      minlength: "＊최소 {0}글자 이상 입력하세요.",
    },
      email: {
      required: "＊필수 입력 항목입니다.",
      email: "＊올바른 이메일 형식으로 입력하세요.",
    },
      phoneNum: {
      required: "＊필수 입력 항목입니다.",
      digits: "＊반드시 숫자만 입력하세요.",
      maxlength: "＊최대 {0}글자 이하 입력하세요.",
    }
  },
});
