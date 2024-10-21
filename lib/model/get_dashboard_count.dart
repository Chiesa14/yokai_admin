// To parse this JSON data, do
//
//     final getDashboardCount = getDashboardCountFromJson(jsonString);

import 'dart:convert';

GetDashboardCount getDashboardCountFromJson(String str) => GetDashboardCount.fromJson(json.decode(str));

String getDashboardCountToJson(GetDashboardCount data) => json.encode(data.toJson());

class GetDashboardCount {
  String? status;
  String? message;
  int? noOfUsers;
  int? storiesPosted;
  int? totalChaptersAcrossAllStories;
  int? activitiesListed;
  int? charactersPosted;
  int? avgNoOfActivitiesPerStory;
  int? blockedUsers;

  GetDashboardCount({
    this.status,
    this.message,
    this.noOfUsers,
    this.storiesPosted,
    this.totalChaptersAcrossAllStories,
    this.activitiesListed,
    this.charactersPosted,
    this.avgNoOfActivitiesPerStory,
    this.blockedUsers,
  });

  factory GetDashboardCount.fromJson(Map<String, dynamic> json) => GetDashboardCount(
    status: json["status"],
    message: json["message"],
    noOfUsers: json["no_of_users"],
    storiesPosted: json["stories_posted"],
    totalChaptersAcrossAllStories: json["total_chapters_across_all_stories"],
    activitiesListed: json["activities_listed"],
    charactersPosted: json["characters_posted"],
    avgNoOfActivitiesPerStory: json["avg_no_of_activities_per_story"],
    blockedUsers: json["blocked_users"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "no_of_users": noOfUsers,
    "stories_posted": storiesPosted,
    "total_chapters_across_all_stories": totalChaptersAcrossAllStories,
    "activities_listed": activitiesListed,
    "characters_posted": charactersPosted,
    "avg_no_of_activities_per_story": avgNoOfActivitiesPerStory,
    "blocked_users": blockedUsers,
  };
}
