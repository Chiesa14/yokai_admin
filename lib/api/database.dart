class DatabaseApi {
  static String mainUrl = "http://10.12.74.244:8000/v1";
  static String mainUrlForImage = "http://10.12.74.244:8000";
//   static String mainUrl = "https://yokai.anantkaal.com/v1";
//   static String mainUrlForImage = "https://yokai.anantkaal.com/";
  static String uploadDocument = "${mainUrl}/user_profile/upload-document/";

  static String login = "${mainUrl}/user_profile/userLogin";
  static String create = "${mainUrl}/user_profile/createUser";

  static String getAllUser = '${mainUrl}/user_profile/getalluser?search=';
  static String getAllBlockedUser =
      '${mainUrl}/user_profile/getallblockuser?search=';
  static String deleteUserByToken =
      '${mainUrl}/user_profile/delete-User-By-Admin?id=';
  static String deleteAndBlockUser =
      '${mainUrl}/user_profile/update-account-status';

  static String getDashboardCount =
      '${mainUrl}/user_profile/get-dashboard-count';

  static String createStories = '${mainUrl}/stories/create-stories';
  static String updateStories = '${mainUrl}/stories/update-stories/';
  static String deleteStories = '${mainUrl}/stories/delete-stories/';
  static String getStoriesByStoryId =
      "${mainUrl}/stories/get-stories-By-Token/";
  // static String getStories = "${mainUrl}/stories/get-all-stories-By-user-Token";
  static String getStories = "${mainUrl}/stories/get-all-stories";

  static String createChapter = '${mainUrl}/chapter/create-chapter';
  static String updateChapter = '${mainUrl}/chapter/update-chapter/';
  static String getAllChapterByStoryId =
      '${mainUrl}/chapter/get-chapter-by-stories';
  static String getAllChapterByChapterId =
      '${mainUrl}/chapter/get-chapter-By-Token/';
  static String deleteChapterByChapterId = '${mainUrl}/chapter/delete-chapter/';

  static String createActivity = '${mainUrl}/activity/create-activity';
  static String createActivityDetails =
      '${mainUrl}/activity_details/create-activity-details';
  static String updateActivity = '${mainUrl}/activity/update-activity/';
  static String updateActivityDetailsById =
      '${mainUrl}/activity_details/update-activity-details/';
  // static String getAllActivity = '${mainUrl}/activity/get-all-activity-By-user-Token';
  static String getAllActivity = '${mainUrl}/activity/get-all-activity';
  // static String getActivityById = '${mainUrl}/activity/get-activity-By-Token/';
  static String getActivityById =
      '${mainUrl}/activity_details/get-activity-details-By-Token/';
  static String deleteActivityById = '${mainUrl}/activity/delete-activity/';
  static String deleteActivityDetailById =
      '${mainUrl}/activity_details/delete-activity-details/';

  static String createCharacters = '${mainUrl}/character/create-character';
  static String getCharacters =
      "${mainUrl}/character/get-all-character?search=";
  static String getCharactersById = "${mainUrl}/character/get-character-by-id/";
  static String deleteCharactersById = '${mainUrl}/character/delete-character/';
  static String updateCharactersById = '${mainUrl}/character/update-character/';
}
