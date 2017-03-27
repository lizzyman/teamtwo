package com.meister.opensource.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
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

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;

public class OpenSourceViewListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OpenSourceViewListServlet() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/opensource/list.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String search = request.getParameter("search");

		System.out.println(search);

		StringBuilder urlBuilder = new StringBuilder("https://searchcode.com/api/codesearch_I/");
		urlBuilder.append("?" + URLEncoder.encode("q", "UTF-8") + "=" + search + "+ext:md");

		System.out.println(urlBuilder.toString());

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");

		System.out.println("Response code: " + conn.getResponseCode());

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

		System.out.println(sb.toString());
		rd.close();
		conn.disconnect();

		JSONObject object = new JSONObject(sb.toString());
		List<String> listApi = new ArrayList<String>();

		JSONArray arr = object.getJSONArray("results"); // 배열단위로 추출하고 싶을때
		String total = object.get("total").toString(); // Object로 추출하고 싶을때

		StringBuffer list = new StringBuffer();

		for (int i = 0; i < arr.length(); i++) {
			
			System.out.println(arr.getJSONObject(i).toString() + "\n\n");
			
			listApi.add(arr.getJSONObject(i).toString() + "\n\n");
		}
		request.setAttribute("count", total);
		request.setAttribute("sourceList", list);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/opensource/list.jsp");
		dispatcher.forward(request, response);

	}

}
