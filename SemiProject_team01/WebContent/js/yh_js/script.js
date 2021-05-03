// https://www.youtube.com/watch?v=5L6h_MrNvsk

const tabs = document.querySelectorAll('[data-tab-target]');
const tabContents = document.querySelectorAll('[data-tab-content]');

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
	  
    const target = document.querySelector(tab.dataset.tabTarget);
    console.log(tab.innerHTML);
    $.ajax({
		   url:"/SemiProject_team01/cscenter/csFaq.to",
		   type:"get",
		   data:{"fcname" : tab.innerHTML},
	   	   dataType:"json",
	   	   success:function(json) {
	   		var html = "";
	   			html += "<table class='table table-hover table-expandable table-striped'>" + 
		   	    "<thead>" + 
		   	      "<tr>" +
		   	        "<th>NO</th>" +
		   	        "<th>분류</th>"+
		   	        "<th>제목</th>"+
		   	      "</tr>"+
		   	    "</thead>" +
		   	    "<tbody>";
	   			$.each(json, function(index, item){
				   			html += "<tr>"+
			   					"<td>"+item.faqNo+"</td>"+
			   					"<td>"+item.fcname+"</td>"+
			   					"<td>"+item.faqtitle+"</td>"+
		   					"</tr>"+
		   				"<tr>"+
		   					"<td colspan='4'>"+item.faqcontent +"</td>"+		   					
		   				"</tr>";
		   			}); // end of each ---------------------------------------------
		   	      html +=  "</tbody>"+
		   	     "</table>";
	   		$("div.ajax_table").html(html);
	   	   },
	   	   error: function(request, status, error){
		      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });// end of ajax--------------------
    
    tabContents.forEach(tabContent => {
      tabContent.classList.remove('active');
    });
    tabs.forEach(tab => {
      tab.classList.remove('active');
    });
    target.classList.add('active');
    tab.classList.add('active');
    
    
    
  });
  
  
});