// initializ
$(document).ready(function(){

    var events = function(json) {

      $('#media li').remove();

      for(var i in json.files){
        $('#media').append("<li class=\"span3\"><a href=\"" 
           + json.files[i].path 
           + "\"><img class=\"thumbnail\" src=\"" 
           + json.files[i].thumbnail + "\">"
           + "<div class=\"status\">"
           + "<span class=\"\">再生数:" + json.files[i].count + "</span><span class=\"right\">"
           + json.files[i].length + "</span></div>"
           + "<div class=\"span3 cls\">" 
           + json.files[i].name + "</div></a></li>");
      }
    }

    var ranking = function(json) {

      $('#media li').remove();

      for(var i in json.files){
        $('#media').append("<li class=\"span9\">"
           + "<a href=\"" + json.files[i].path + "\">"
           + "<div class=\"row\">"
           + "<div class=\"span3\">"
           + "<img class=\"thumbnail\" src=\"" + json.files[i].thumbnail + "\" />"
           + "</div>"
           + "<div class=\"span4\">"
           + "<div>" + json.files[i].name + "</div>"
           + "<div>" + json.files[i].path.replace(/\/video\//,"").replace(/\/[^\/]+$/,"").replace(/\//g," ").replace(/[\d]+_/,"") + "</div>"
           + "<div>再生数: " + json.files[i].count + "</div>"
           + "<div>再生時間: " + json.files[i].length + "</div>"
           + "</div></div></a>"
           + "<span class=\"ranknumber\">" + (i*1+1) + "</span>"
           + "</li>");
      }
    }

    var category_select = function(json){
      var rep = ""
      var map = {}
      for(var i in json.categorys){
          if (rep != "" && json.categorys[i].path.match(rep)){
            map[rep][map[rep].length] = json.categorys[i];
          } else {
            rep = json.categorys[i].path;
            map[rep] = [];
            map[rep][0] = json.categorys[i];
          }
      }

      return map;
    } 

    var link_generate = function(map){
      for(var i in map){

        var html = "";
        var label = {true : "success", false : "important"}

        if(map[i].length > 1){
          html = "<li><span class=\"label " + label[map[i][0].complete] + "\" /><a class=\"categoryselecter\" href=\"#"
          + map[i][0].path + "\">"
          + map[i][0].name + "</a><ul>";

          map[i].shift();
          for(var j in map[i]){
              html += "<li><span class=\"label " + label[map[i][j].complete] + "\" /><a class=\"categoryselecter\" href=\"#"
              + map[i][j].path + "\">"
              + map[i][j].name + "</a></li>";
          }

          html += "</ul></li>";
        } else {
          html = "<li><span class=\"label " + label[map[i][0].complete] + "\" /><a class=\"categoryselecter\" href=\"#"
          + map[i][0].path + "\">"
          + map[i][0].name + "</a></li>";
        }

        $('#subcontent').append(html);
        $('#subcontent > li > ul').css('display','none');
      }
    }

    var count = function(data){
      $('#total_count').append(data["count"])
    }
    
    var category = function(json){

      var map = category_select(json);
      link_generate(map);

      $('.categoryselecter').click(function(){
        $('#subtitle').text($(this).text());
        category_name =  $(this).attr("href").replace("#","");
        
        if ($(this).parent().children('ul').css('display') == 'none'){
          $(this).parent().children('ul').css('display','block');
        } else {
          $(this).parent().children('ul').css('display','none');
        }
        $.getJSON("/category/" + category_name, events); 
      });
    }

    $('#latest').click(function(){
      $('#subtitle').text("Latest");
      $.getJSON("/latest", events);
    });

    $('#rank').click(function(){
      $('#subtitle').html("Ranking <a id='prerank' class='sublink'>Yesterday</a>");
      $('#prerank').click(function(){
         $('#subtitle').text("Yesterday Ranking");
         $.getJSON("/rank/yesterday", ranking);
      });
      $.getJSON("/rank", ranking);
    });

    $('#search').submit(function(){
      $.getJSON("/search/" + $('#q').val(), events);
    });


    $.getJSON("/categorys", category);
    $('#latest').click();

    $.getJSON("/count", count);

});
