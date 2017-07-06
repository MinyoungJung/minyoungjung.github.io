---
layout: post
title: 안드로이드에 Facebook Graph API 사용하기
category: [안드로이드]
tags: [Android, Java, Facebook SDK, REST API, Auth, Graph API]
---

# Graph API 사용 Flow
## 인증 후 AccessToken 획득
`AccessToken accessToken = AccessToken.getCurrentAccessToken();`

## Graph Request 생성
accessToken, URL endpoint, params, HttpMethod, Callback method를 인자로 생성  
이후 `executeAsync()`로 비동기 실행  

**예제 1 - 사용자 이름 얻기**
``` java
GraphRequest request = GraphRequest.newMeRequest(accessToken,
    new GraphRequest.GraphJSONObjectCallback() {
    @Override
        public void onCompleted(
            JSONObject object,
            GraphResponse response) {
        try {
            mTextView.setText("Logged in as:" + object.getString("name"));
        } catch (JSONException je) {
            Log.e("FB", "No key provided.");
        }
    }
});
Bundle parameters = new Bundle();
parameters.putString("fields", "id,name,link");
request.setParameters(parameters);
request.executeAsync();
```
**예제 2 - 페이스북 페이지에 게시물 포스팅**
``` java
new GraphRequest(
    AccessToken.getCurrentAccessToken(),
    "/912605208889540/feed", // 페이지 ID
    params,
    HttpMethod.POST,
    new GraphRequest.Callback() {
    public void onCompleted(GraphResponse response) {
        Toast.makeText(getBaseContext(), "Write Complete", Toast.LENGTH_SHORT).show();
        }
    }
).executeAsync();
```

**예제 3 - 페이스북 페이지 게시물 가져오기**
``` java
new GraphRequest(
    AccessToken.getCurrentAccessToken(),
    "/912605208889540/feed",
    null,
    HttpMethod.GET,
    new GraphRequest.Callback() {
        public void onCompleted(GraphResponse response) {
            JSONObject jsonObj = response.getJSONObject();
            JSONArray jsonArray = null;
        try {
            jsonArray = jsonObj.getJSONArray("data");
        } catch (JSONException je) {
            Log.e("FB", "Error fetching JSON");
        }
    }
).executeAsync();
```

## 기타 확인할 것
1. Facebook 개발자 페이지에서 `앱 검수` 항목에서 쓰기 권한 검수 받기  
2. Facebook 개발자 페이지에서 앱 공개해서 SANDBOX에서 실행되지 않도록 할 것  
(앱 공개 안하면 안드로이드 앱을 통해 Publishing한 포스트들이 다른 사람에게 보이지 않음)
