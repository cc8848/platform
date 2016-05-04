package com.xmbl.ops.constant;

public class CommonConstant {
	public static String teacher_api_url;
	public static String question_id_url;
	public void setTeacher_api_url(String teacher_api_url) {
		CommonConstant.teacher_api_url = teacher_api_url;
		TEACHER_ADD = CommonConstant.teacher_api_url+"teacher/api/orgteachersetting/addOrgTeacherMapping";//测试环境教师端 新增机构教师接口
		TEACHER_CHANGE_STATUS = CommonConstant.teacher_api_url+"teacher/api/orgteachersetting/changeStatus";//测试环境教师端  删除，再次邀请 加入机构接口
		TEACHER_QUESTION = CommonConstant.teacher_api_url+"teacher/api/orgteachersetting/getStudentIdsByQuestionIds";//测试环境教师API查询教师解答对应学生
	}
	public void setQuestion_id_url(String question_id_url) {
		CommonConstant.question_id_url = question_id_url;
		QUESTION_ID_URL = CommonConstant.question_id_url+"api/srv/search/docidd/";//获取题目详情接口
	}
	public static String TEACHER_ADD = null;
	public static String TEACHER_CHANGE_STATUS = null;
	public static String TEACHER_QUESTION = null;
	public static String QUESTION_ID_URL = null;
	
//  正式地址	
//	public static String UPLOAD_RECOG_URL = "http://imgapi02.91xuexibao.com/imgapi02"; //上传识别文件的url
//	public static String RECOG_URL = "http://service02.91xuexibao.com/api/srv/search/qimage2"; //识别操作的url;
//	public static final String TEACHER_QUERYURL = "teacher.91xuexibao.com/teacherMs/api/student/queryOrganization";//测试环境教师后台查询接口
//	public static final String TEACHER_QUERYONEURL = "teacher.91xuexibao.com/teacherMs/api/student/selectOrganizationById";//测试环境教师后台查询接口
//	public static final String TEACHER_URL = "teacher.91xuexibao.com/teacherMs/api/student/insertOrgQuest";//教师后台插入接口

	

}
