package com.meister.opensource.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.util.Arrays;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.meister.commom.constants.AuthConst;
import com.meister.opensource.vo.LanguageVO;
import com.meister.opensource.vo.SearchResultVO;

import com.meister.opensource.vo.SourceVO;

public class OpenSourceViewListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OpenSourceViewListServlet() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		String pageNum = request.getParameter("pageNum");
		String langId = request.getParameter("langId");
		String srcId = request.getParameter("srcId");

		if (pageNum != null) {
			
			doPost(request, response);

		} else if (langId != null) {

			doPost(request, response);

		} else if (srcId != null) {

			doPost(request, response);

		} else {

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/opensource/search.jsp");
			dispatcher.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		String langId = request.getParameter("langId");
		String srcId = request.getParameter("srcId");
		String search = (request.getParameter("search") == null) ? request.getParameter("q") :  request.getParameter("search"); 
		String pageNum = (request.getParameter("pageNum") == null) ? "0" : request.getParameter("pageNum");
		
		langId = (langId == null) ? "" :  "&lan=" + langId;
		srcId = (srcId == null) ? "" : "&src=" + srcId;

	
		System.out.println(search);
		System.out.println(pageNum);

		
		search = search.replaceAll(" ", "+");

		StringBuilder urlBuilder = new StringBuilder("https://searchcode.com/api/codesearch_I/");

		urlBuilder.append("?" + URLEncoder.encode("q", "UTF-8") + "=" + "readme+" + search + "&p=" + pageNum + langId+srcId);


		URL url = new URL(urlBuilder.toString());
		System.out.println("first address = " + urlBuilder.toString());

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");

		BufferedReader rd;

		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}

		rd.close();
		conn.disconnect();

		// System.out.println("first parsing = " + sb.toString());

		JSONObject object = new JSONObject(sb.toString());

		JSONArray resultarr = object.getJSONArray("results"); // 諛곗뿴?⑥쐞濡?異붿텧?섍퀬
																// ?띠쓣??
		JSONArray langArr = object.getJSONArray("language_filters");
		JSONArray sourceArr = object.getJSONArray("source_filters");

		// System.out.println("sourceArr = " + sourceArr.toString());

		String total = object.get("total").toString(); // Object濡?異붿텧?섍퀬 ?띠쓣??
		String page = object.get("page").toString(); // Object濡?異붿텧?섍퀬 ?띠쓣??

		Gson gson = new Gson();

		TypeToken<List<SearchResultVO>> token = new TypeToken<List<SearchResultVO>>() {};
		List<SearchResultVO> resultList = gson.fromJson(resultarr.toString(), token.getType());

		TypeToken<List<LanguageVO>> token2 = new TypeToken<List<LanguageVO>>() {};
		List<LanguageVO> langList = gson.fromJson(langArr.toString(), token2.getType());

		TypeToken<List<SourceVO>> token3 = new TypeToken<List<SourceVO>>() {};
		List<SourceVO> sourceList = gson.fromJson(sourceArr.toString(), token3.getType());

		request.setAttribute("results", resultList);
		request.setAttribute("languages", langList);
		request.setAttribute("sources", sourceList);

		request.setAttribute("page", page);
		request.setAttribute("search", search);
		request.setAttribute("count", total);
		request.setAttribute("includeUrl", "/WEB-INF/view/opensource/list.jsp");

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/opensource/search.jsp");
		dispatcher.forward(request, response);

	}

}
