<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*, java.util.*, org.json.simple.*" %>
<%@ page import="org.json.simple.parser.*" %>
<!-- https://mvnrepository.com/artifact/org.json/json/20231013 에서 json다운, web-inf 에 카피 -->

<%!
private static Map<String, String> getItemNames() {
    Map<String, String> itemNames = new HashMap<>();
    
    // 일반 아이템
    itemNames.put("30011", "원암");
    itemNames.put("30012", "원암 큐브");
    itemNames.put("30013", "원암 클러스터");
    itemNames.put("30014", "원암 정제석");
    itemNames.put("30021", "설탕");
    itemNames.put("30022", "설탕 팩");
    itemNames.put("30023", "설탕 덩어리");
    itemNames.put("30024", "설탕 알갱이");
    itemNames.put("30031", "포리에스테르");
    itemNames.put("30032", "포리에스테르 팩");
    itemNames.put("30033", "포리에스테르 덩어리");
    itemNames.put("30034", "포리에스테르 시트");
    itemNames.put("30041", "대체당");
    itemNames.put("30042", "대체당 팩");
    itemNames.put("30043", "대체당 덩어리");
    itemNames.put("30044", "대체당 복합체");
    itemNames.put("30051", "이철");
    itemNames.put("30052", "이철 조각");
    itemNames.put("30053", "이철 덩어리");
    itemNames.put("30054", "이철 주괴");
    itemNames.put("30061", "장치");
    itemNames.put("30062", "통합 장치");
    itemNames.put("30063", "신형 통합 장치");
    itemNames.put("30064", "개량형 장치");
    itemNames.put("30073", "아케인 주괴");
    itemNames.put("30074", "아케인 정제석");
    itemNames.put("30083", "망간 광석");
    itemNames.put("30084", "망간 중합체");
    itemNames.put("30093", "연마석");
    itemNames.put("30094", "결정 연마석");
    itemNames.put("30103", "RMA70-12");
    itemNames.put("30104", "RMA70-24");
    itemNames.put("30115", "불안정 파쇄석");
    itemNames.put("30125", "결정 부품");
    itemNames.put("30135", "반백석 결정");
    itemNames.put("30145", "D32강");
    itemNames.put("31013", "코발트");
    itemNames.put("31014", "코발트 중합체");
    itemNames.put("31023", "아콘진");
    itemNames.put("31024", "정제 아콘진");

    // 스킬 교본
    itemNames.put("3301", "기술 자재");
    itemNames.put("3302", "숙련 기술 자재");
    itemNames.put("3303", "기술 자료");

    // 작전 기록
    itemNames.put("2001", "기초 작전 기록");
    itemNames.put("2002", "초급 작전 기록");
    itemNames.put("2003", "중급 작전 기록");
    itemNames.put("2004", "고급 작전 기록");

    // 랜덤 재료
    itemNames.put("randomMaterial_1", "랜덤 T1 재료");
    itemNames.put("randomMaterial_2", "랜덤 T2 재료");
    itemNames.put("randomMaterial_3", "랜덤 T3 재료");
    itemNames.put("randomMaterial_4", "랜덤 T4 재료");
    itemNames.put("randomMaterial_5", "랜덤 T5 재료");
    itemNames.put("randomMaterial_6", "랜덤 초월 재료");
    itemNames.put("randomMaterial_7", "랜덤 이벤트 재료");
    itemNames.put("randomMaterial_8", "랜덤 특수 재료");

    // 특수 아이템
    itemNames.put("ap_supply_lt_010", "작전 협력증");
    itemNames.put("4001", "LMD");
    itemNames.put("furni", "가구 부품");
    
    //카본
    itemNames.put("3112", "카본");
	itemNames.put("3113", "카본번들");
	itemNames.put("3114", "카본 팩");
	
	//순금
	itemNames.put("3003", "순금");
    
    return itemNames;
}

// API에서 드롭 데이터를 가져오는 함수
public String fetchFromAPI(String stageFilter) {
    try {
        String apiUrl = "https://penguin-stats.io/PenguinStats/api/v2/result/matrix?server=CN";
        if (stageFilter != null && !stageFilter.isEmpty()) {
            apiUrl += "&stageFilter=" + URLEncoder.encode(stageFilter, "UTF-8");
        }
        
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        BufferedReader reader = new BufferedReader(
            new InputStreamReader(conn.getInputStream())
        );
        StringBuilder response = new StringBuilder();
        String line;
        
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        
        return response.toString();
    } catch (Exception e) {
        return "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이템 드롭률 테이블</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        
        .filter-form {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .filter-form label {
            font-weight: bold;
            margin-right: 10px;
        }
        
        .filter-form input[type="text"] {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .filter-form input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .table-container {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f2f2f2;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .item-name {
            font-weight: bold;
            color: #333;
        }
        
        .item-id {
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>아이템 드롭률 테이블 (KR 서버)</h1>

        <div class="filter-form">
            <form method="get">
                <label for="stage">스테이지 필터:</label>
                <input type="text" id="stage" name="stage" value="<%= request.getParameter("stage") != null ? request.getParameter("stage") : "" %>">
                <input type="submit" value="필터 적용">
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>스테이지</th>
                        <th>아이템</th>
                        <th>획득 수량</th>
                        <th>시도 횟수</th>
                        <th>드롭률 (%)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Map<String, String> itemNames = getItemNames();
                        String jsonData = fetchFromAPI(request.getParameter("stage"));
                        JSONParser parser = new JSONParser();
                        JSONObject jsonObject = (JSONObject) parser.parse(jsonData);
                        JSONArray matrix = (JSONArray) jsonObject.get("matrix");

                        List<JSONObject> sortedMatrix = new ArrayList<>();
                        for (Object obj : matrix) {
                            JSONObject item = (JSONObject) obj;
                            sortedMatrix.add(item);
                        }

                        Collections.sort(sortedMatrix, new Comparator<JSONObject>() {
                            @Override
                            public int compare(JSONObject a, JSONObject b) {
                                double rateA = ((Number)a.get("quantity")).doubleValue() / ((Number)a.get("times")).doubleValue();
                                double rateB = ((Number)b.get("quantity")).doubleValue() / ((Number)b.get("times")).doubleValue();
                                return Double.compare(rateB, rateA);
                            }
                        });

                        for (JSONObject item : sortedMatrix) {
                            long times = ((Number)item.get("times")).longValue();
                            if (times > 0) {
                                long quantity = ((Number)item.get("quantity")).longValue();
                                double dropRate = (double) quantity / times * 100;
                                String itemId = (String)item.get("itemId");
                                String itemName = itemNames.getOrDefault(itemId, itemId);
                                %>
                                <tr>
                                    <td><%= item.get("stageId") %></td>
                                    <td>
                                        <div class="item-name"><%= itemName %></div>
                                        <div class="item-id">(<%= itemId %>)</div>
                                    </td>
                                    <td><%= String.format("%,d", quantity) %></td>
                                    <td><%= String.format("%,d", times) %></td>
                                    <td><%= String.format("%.2f", dropRate) %>%</td>
                                </tr>
                                <%
                            }
                        }
                    } catch (Exception e) {
                        %>
                        <tr>
                            <td colspan="5" style="color: red;">
                                에러가 발생했습니다: <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>