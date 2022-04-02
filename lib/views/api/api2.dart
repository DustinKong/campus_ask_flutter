// api 接口
class Api2 {
  // static const String BASE_URL = 'http://192.144.169.239/kt';
  ///黄茂祥api
  static const String BASE_URL = 'http://212.64.40.135:8003';
  static const String InstitutionList = BASE_URL + '/Institution/list'; //查询所有机构
  static const String SearchCourses = BASE_URL + '/Course/SearchCourses'; //按照关键词查询课程(首页)
  static const String TopCourses = BASE_URL + '/Course/topCourses'; //查看评分最高的top20课程(首页)
  static const String IsConcernInst = BASE_URL + '/Concern/isConcernInst'; //关注或者取消关注一个机构
  static const String IsConcernCourse = BASE_URL + '/Concern/isConcernCourse'; //关注或者取消关注一门课程
  static const String IsConcernTeacher = BASE_URL + '/Concern/isConcernTeacher'; //关注或者取消关注一个讲师
  static const String ConcernList = BASE_URL + '/Concern/concernList'; //查看关注的机构、老师、课程
  static const String InstCourseList = BASE_URL + '/Course/InstCourseList'; //通过机构id查看机构的所有课程
  static const String TeacherCourseList = BASE_URL + '/Course/TeacherCourseList'; //通过讲师id查看该讲师的所有课程
  static const String GetInstByCourse = BASE_URL + '/Institution/getInstByCourse'; //根据课程id查找它所属的机构信息
  static const String IsMyConcern = BASE_URL + '/Concern/isMyConcern'; //查看用户是否已经关注了某个机构、讲师或者课程
  static const String CouponList = BASE_URL + '/Coupon/list'; //根据用户id查找该用户的所有优惠券
  static const String TypeCourses = BASE_URL + '/Course/TypeCourses'; //依照类别查看课程
  static const String CourseCommentList = BASE_URL + ' /Comment/CourseCommentList'; //查看一门课程的所有评论
  static const String PayOrder = BASE_URL + ' /Order/payOrder'; //订单付款

  static const String GetCourseNotice = BASE_URL + ' /StudyCourse/getCourseNotice'; //查看课程公告
  static const String GetCourseResource = BASE_URL + ' /StudyCourse/getCourseResource'; //查看课程资料
  static const String GetCourseVideo = BASE_URL + ' /StudyCourse/getCourseVideo'; //查看课程视频
  static const String GetMyCourseAll = BASE_URL + ' /StudyCourse/getMyCourseAll'; //查找我报名学习的全部课程 deprived
  static const String GetOnlineCourses = BASE_URL + '/StudyCourse/getOnlineCourses'; //查找我的线上或线下课程

  static const String GetLastStudyCourse = BASE_URL + '/StudyCourse/getLastStudyCourse'; //查看我的继续学习课程
  static const String RecordWatchVideo = BASE_URL + '/StudyCourse/watchVideo'; //点击观看视频，记录学习数据(线上课)
  static const String StudyVideoHistory = BASE_URL + '/personalCenter/studyVideoHistory'; //查询我所有的视频观看历史记录
  static const String ViewsRecord = BASE_URL + '/personalCenter/viewsRecord'; //查询我所有的浏览记录
  static const String AddViewCourseRecourd = BASE_URL + '/personalCenter/addViewCourseRecourd'; //点击课程，添加浏览记录(首页、课程页)
  static const String CancelUser = BASE_URL + '/User/cancelUser'; //注销用户



}
