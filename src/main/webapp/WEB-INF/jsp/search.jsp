<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/27
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Page</title>
</head>
<style>
    #searchInput {
        width: 200px;
        padding: 10px;
    }


</style>
<body>
<input type="text" id="searchInput" placeholder="Search...">
<ul id="suggestionsList"></ul>

<script>

    var arr = [
        <%
            String[] arrFromJava = (String[]) request.getAttribute("arr");
            if (arrFromJava != null) {
                for (int i = 0; i < arrFromJava.length; i++) {
                    out.print("'" + arrFromJava[i].replace("'", "\\'") + "'");
                    if (i < arrFromJava.length - 1) {
                        out.print(",");
                    }
                }
            }
        %>
    ];
    const searchBox = document.getElementById('search-box');
    var searchInput = document.getElementById("searchInput");
    var suggestionsList = document.getElementById("suggestionsList");

    // 莱文斯坦距离算法
    function levenshteinDistance(a, b) {
        if (a.length === 0) return b.length;
        if (b.length === 0) return a.length;

        var matrix = [];

        for (var i = 0; i <= b.length; i++) {
            matrix[i] = [i];
        }

        for (var j = 0; j <= a.length; j++) {
            matrix[0][j] = j;
        }

        for (var i = 1; i <= b.length; i++) {
            for (var j = 1; j <= a.length; j++) {
                if (b.charAt(i - 1) === a.charAt(j - 1)) {
                    matrix[i][j] = matrix[i - 1][j - 1];
                } else {
                    matrix[i][j] = Math.min(
                        matrix[i - 1][j - 1] + 1,
                        matrix[i][j - 1] + 1,
                        matrix[i - 1][j] + 1
                    );
                }
            }
        }

        return matrix[b.length][a.length];
    }

    searchInput.addEventListener("input", function () {
        var keyword = searchInput.value.toLowerCase();
        var matchedSuggestions = arr.filter(function (item) {
            return levenshteinDistance(keyword, item.toLowerCase()) <= 3;
        });

        suggestionsList.innerHTML = "";

        matchedSuggestions.forEach(function (suggestion) {
            var li = document.createElement("li");
            li.textContent = suggestion;
            li.addEventListener('click', () => {
                searchInput.value = suggestion;
                suggestionsList.innerHTML = '';
            });
            suggestionsList.appendChild(li);
        });
    });
</script>
</body>

</html>