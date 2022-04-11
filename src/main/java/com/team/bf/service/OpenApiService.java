package com.team.bf.service;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.io.BufferedReader;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class OpenApiService {
    @Value("${open-api.myKey}")
    private String myKey;

    //1. 지역코드 조회
    public ArrayList<JSONObject> AreaInfo(){
        StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/areaCode"); /*URL*/
        StringBuilder sb = new StringBuilder();
        JSONObject json = null;
        ArrayList<JSONObject> items = new ArrayList<>();
        
        try {
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+myKey); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*현재 페이지 번호*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), ETC*/
            urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("barrier-free", "UTF-8")); /*서비스명=어플명*/
           // urlBuilder.append("&" + URLEncoder.encode("areaCode","UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*지역코드, 시군구코드*/
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            json = XML.toJSONObject(sb.toString());
          


            System.out.println("in api \n"+ json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
        JSONObject response = json.getJSONObject("response").getJSONObject("body").getJSONObject("items");
        JSONArray jsonArray = response.getJSONArray("item");
        for(Object obj : jsonArray) items.add((JSONObject)obj);
        return items;
    }
    //3. 위치 기반 관광지 조회
    public ArrayList<JSONObject> locationBasedList(String pageNo, String pageCount, String contentTypeId, String mapX, String mapY){
    	StringBuilder urlBuilder = null;
        StringBuilder sb = new StringBuilder();
        JSONObject json = null;
        ArrayList<JSONObject> items = new ArrayList<>(); //결과 목록
        
        try {
        	
        	urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/locationBasedList"); /*URL*/
          
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+myKey); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); /*현재 페이지 번호*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(pageCount, "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), ETC*/
            urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
            urlBuilder.append("&" + URLEncoder.encode("areaCode","UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*지역코드, 시군구코드*/
            urlBuilder.append("&" + URLEncoder.encode("listYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); 
            urlBuilder.append("&" + URLEncoder.encode("arrange","UTF-8") + "=" + URLEncoder.encode("O", "UTF-8")); /*  (A=제목순, B=조회순, C=수정일순, D=생성일순) 대표이미지가 반드시 있는 정렬 (O=제목순, P=조회순, Q=수정일순, R=생성일순)*/
            urlBuilder.append("&" + URLEncoder.encode("mapX","UTF-8") + "=" + URLEncoder.encode(mapX, "UTF-8")); // 경도 
            urlBuilder.append("&" + URLEncoder.encode("mapY","UTF-8") + "=" + URLEncoder.encode(mapY, "UTF-8")); //위도 
            //urlBuilder.append("&" + URLEncoder.encode("radius","UTF-8") + "=" + URLEncoder.encode(radius, "UTF-8"));

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            json = XML.toJSONObject(sb.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
        System.out.println(json.toString());
        int totalCount = json.getJSONObject("response").getJSONObject("body").getInt("totalCount");
        
        //토탈 개수 이하일 경우에만 items 리스트 생성
        if(totalCount >= Integer.parseInt(pageNo)*Integer.parseInt(pageCount)){
            JSONObject response = json.getJSONObject("response").getJSONObject("body").getJSONObject("items");
            JSONArray jsonArray = response.getJSONArray("item");
            System.out.println(jsonArray.toString());
            for(int i=0; i<jsonArray.length(); i++) {
            	JSONObject jObj = jsonArray.getJSONObject(i);
            	items.add(jObj);
            }
        }
        
        return items;
    }
    //5. 키워드 검색 조회 기능
    public ArrayList<JSONObject> searchKeyword(String pageNo, String pageCount, String contentTypeId, String searchWord){
        StringBuilder urlBuilder = null;
        StringBuilder sb = new StringBuilder();
        JSONObject json = null;
        ArrayList<JSONObject> items = new ArrayList<>(); //결과 목록
        
        try {
            //검색어가 없을 경우
            if(searchWord.equals(""))
                urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/areaBasedList"); /*URL*/
            //검색어가 있을 경우
            else{
                urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/searchKeyword"); /*URL*/
            }
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+myKey); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); /*현재 페이지 번호*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(pageCount, "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), ETC*/
            urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
            urlBuilder.append("&" + URLEncoder.encode("areaCode","UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*지역코드, 시군구코드*/
           // urlBuilder.append("&" + URLEncoder.encode("listYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); 
            urlBuilder.append("&" + URLEncoder.encode("arrange","UTF-8") + "=" + URLEncoder.encode("P", "UTF-8")); /*  (A=제목순, B=조회순, C=수정일순, D=생성일순) 대표이미지가 반드시 있는 정렬 (O=제목순, P=조회순, Q=수정일순, R=생성일순)*/
            
            //모든 관광지를 조회할 시
            if(contentTypeId.equals("all") == false)
            	urlBuilder.append("&" + URLEncoder.encode("contentTypeId","UTF-8") + "=" + URLEncoder.encode(contentTypeId, "UTF-8")); /* 관광지 12, 문화시설 14, 행사/공연/축제 15 , 레포츠 28, 숙박32, 쇼핑 38*/
           
            if(!searchWord.equals(""))
                urlBuilder.append("&" + URLEncoder.encode("keyword","UTF-8") + "=" + URLEncoder.encode(searchWord, "UTF-8")); /*지역코드, 시군구코드*/
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            json = XML.toJSONObject(sb.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
        System.out.println(json.toString());
        int totalCount = json.getJSONObject("response").getJSONObject("body").getInt("totalCount");
        
        //토탈 개수 이하일 경우에만 items 리스트 생성
        if(totalCount >= Integer.parseInt(pageNo)*Integer.parseInt(pageCount)){
            JSONObject response = json.getJSONObject("response").getJSONObject("body").getJSONObject("items");
            JSONArray jsonArray = response.getJSONArray("item");
            System.out.println(jsonArray.toString());
            for(int i=0; i<jsonArray.length(); i++) {
            	JSONObject jObj = jsonArray.getJSONObject(i);
            	items.add(jObj);
            }
        }
        
        return items;
    }
    
    //6. 공통정보조회(상세정보1)
    public ArrayList<JSONObject> detailCommon(String pageNo, String pageCount, String contentTypeId){
        StringBuilder urlBuilder = null;
        StringBuilder sb = new StringBuilder();
        JSONObject json = null;
        ArrayList<JSONObject> items = new ArrayList<>(); //결과 목록
        
        try {
        	urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/detailCommon"); /*URL*/
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+myKey); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(pageCount, "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); /*현재 페이지 번호*/
            urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), ETC*/
            urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
            urlBuilder.append("&" + URLEncoder.encode("areaCode","UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*지역코드, 시군구코드*/
            urlBuilder.append("&" + URLEncoder.encode("firstImageYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));  //썸네일 조회
            urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode("252581", "UTF-8"));  //썸네일 조회
            urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode("138185", "UTF-8"));  //썸네일 조회
            urlBuilder.append("&" + URLEncoder.encode("defaultYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));  //썸네일 조회
            
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            json = XML.toJSONObject(sb.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
        System.out.println(json.toString());
        int totalCount = json.getJSONObject("response").getJSONObject("body").getInt("totalCount");
        
        //토탈 개수 이하일 경우에만 items 리스트 생성
        if(totalCount >= Integer.parseInt(pageNo)*Integer.parseInt(pageCount)){
            JSONObject response = json.getJSONObject("response").getJSONObject("body").getJSONObject("items");
            JSONArray jsonArray = response.getJSONArray("item");
            System.out.println(jsonArray.toString());
            for(int i=0; i<jsonArray.length(); i++) {
            	JSONObject jObj = jsonArray.getJSONObject(i);
            	items.add(jObj);
            }
        }
        
        return items;
    }
    
    //7. 상세정보 조회
	public JSONObject detailIntro(String contentId, String contentTypeId) {
        StringBuilder urlBuilder = null;
        StringBuilder sb = new StringBuilder();
        JSONObject json = null;
        
        try {
        	urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorWithService/detailIntro"); /*URL*/
            urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+myKey); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), ETC*/
            urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
            urlBuilder.append("&" + URLEncoder.encode("contentTypeId","UTF-8") + "=" + URLEncoder.encode(contentTypeId, "UTF-8")); /* contentId*/
            urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode(contentId, "UTF-8")); /* 관광지 12, 문화시설 14, 행사/공연/축제 15 , 레포츠 28, 숙박32, 쇼핑 38*/

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
           
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            json = XML.toJSONObject(sb.toString());
            System.out.println(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
      
        return json;
    	
    }
}
