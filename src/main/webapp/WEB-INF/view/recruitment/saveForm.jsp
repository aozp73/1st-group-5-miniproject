<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <style>
            * {
                font-weight: normal;
            }
        </style>

        <div class="container my-3">

            <form enctype="multipart/form-data">

                <div class="form-group pb-3">
                    <input type="text" class="form-control form-control-lg" placeholder="Enter title" name="title"
                        id="title" vlaue="제목">
                </div>

                <div class="d-flex justify-content-between pb-3">
                    <div class="border border-end-0 border-start-0 pt-3" style="width: 47%;">
                        <div class="input-group mb-3">
                            <span class="input-group-text">경력</span>
                            <input type="text" class="form-control" list="career_list" placeholder="TEST" name="career"
                                id="career" vlaue="신입">
                            <datalist id="career_list">
                                <option value="신입">
                                <option value="경력">
                                <option value="무관">
                            </datalist>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">학력</span>
                            <input type="text" class="form-control" list="education_list" placeholder="TEST"
                                name="education" id="education" vlaue="학력무관">
                            <datalist id="education_list">
                                <option value="학력무관">
                                <option value="고졸">
                                <option value="초대졸">
                                <option value="대졸">
                            </datalist>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">기업형태</span>
                            <select class="form-select" aria-label="Default select example" name="sector" id="sector">
                                <option selected>Open this select menu</option>
                                <option value="Si">Si</option>
                                <option value="웹에이전시">웹에이전시</option>
                                <option value="인력소싱">인력소싱</option>
                                <option value="대기업">대기업</option>
                                <option value="스타트업">스타트업</option>
                                <option value="서비스">서비스</option>
                                <option value="컨설팅">컨설팅</option>
                            </select>
                        </div>

                    </div>

                    <div class="border border-end-0 border-start-0 pt-3" style=" width: 47%;">
                        <div class="input-group mb-3">
                            <span class="input-group-text">급여</span>
                            <input type="text" class="form-control" list="pay_list" placeholder="TEST" name="pay"
                                id="pay" vlaue="면접 후 결정">
                            <datalist id="pay_list">
                                <option value="면접 후 결정">
                                <option value="@@만원">
                            </datalist>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">근무지역</span>
                            <input type="text" class="form-control" list="address_list" placeholder="TEST"
                                name="address" id="address" vlaue="전국">
                            <datalist id="address_list">
                                <option value="전국">
                                <option value="부산">
                            </datalist>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">희망포지션</span>
                            <select class="form-select" aria-label="Default select example" name="position"
                                id="position">
                                <option selected>Open this select menu</option>
                                <option value="프론트엔드">프론트엔드</option>
                                <option value="백엔드">백엔드</option>
                                <option value="소프트웨어">소프트웨어</option>
                                <option value="안드로이드">안드로이드</option>
                                <option value="IOS">IOS</option>
                                <option value="시스템, 네트워크 관리자">시스템, 네트워크 관리자</option>
                                <option value="머신러닝 엔지니어">머신러닝 엔지니어</option>
                                <option value="데이터 엔지니어">데이터 엔지니어</option>
                                <option value="빅데이터 엔지니어">빅데이터 엔지니어</option>
                                <option value="보안 엔지니어">보안 엔지니어</option>
                                <option value="임베디드개발자">임베디드개발자</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <textarea class="form-control summernote" rows="5" id="content" name="content"></textarea>
                </div>

                <div class="input-group mb-3">
                    <label class="input-group-text" for="logo">
                        로고사진
                    </label>
                    <input type="file" class="form-control" id="enterpriseLogo" name="enterpriseLogo">
                </div>

                <div class="d-flex justify-content-center">
                    <button onclick="save()" type="button" class="btn btn-primary">글쓰기완료</button>
                </div>
            </form>
        </div>

        <script>

            function save() {
                // FormData 객체 생성
                var formData = new FormData();

                // input 요소에서 값을 가져와서 FormData 객체에 추가
                formData.append('title', $('#title').val());
                formData.append('content', $('#content').val());
                formData.append('career', $('#career').val());
                formData.append('education', $('#education').val());
                formData.append('pay', $('#pay').val());
                formData.append('sector', $('#sector').val());
                formData.append('position', $('#position').val());
                formData.append('address', $('#address').val());

                var enterpriseLogoFile = $('#enterpriseLogo')[0].files[0];
                if (enterpriseLogoFile) {
                    // 파일 유형 체크
                    if (!enterpriseLogoFile.type.startsWith('image/')) {
                        alert('이미지 파일만 업로드 가능합니다.');
                        return;
                    }
                    formData.append('enterpriseLogo', enterpriseLogoFile);
                } else {
                    // 
                    alert('파일을 선택해주세요.');
                    return;
                }

                $.ajax({
                    type: 'post',
                    url: '/recruitment',
                    data: formData,
                    contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
                    processData: false, // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
                    dataType: "json"
                }).done((res) => { // 20X 일때
                    alert(res.msg);
                    location.href = "/";
                }).fail((err) => { // 40X, 50X 일때
                    alert(err.responseJSON.msg);
                });
            }
        </script>

        <script>
            $('.summernote').summernote({
                tabsize: 2,
                height: 400,
                disableDragAndDrop: true,
            });
            $('.summernote').summernote(
                'code', '주요업무 <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br><br>자격요건 <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br><br>우대사항 <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br><br>혜택 및 복지 <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>• 미리 작성된 내용입니다. <br>'
            );
        </script>

        <%@ include file="../layout/footer.jsp" %>