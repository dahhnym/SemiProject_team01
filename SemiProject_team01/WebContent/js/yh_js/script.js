// https://www.youtube.com/watch?v=5L6h_MrNvsk

const tabs = document.querySelectorAll('[data-tab-target]');
const tabContents = document.querySelectorAll('[data-tab-content]');

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    const target = document.querySelector(tab.dataset.tabTarget);
    console.log(target);
    tabContents.forEach(tabContent => {
      tabContent.classList.remove('active');
    });
    tabs.forEach(tab => {
      tab.classList.remove('active');
    });
    target.classList.add('active');
    tab.classList.add('active');
    
    $.ajax({
		   url:"<%= request.getContextPath()%>/cscenter/csFaq.to",
		   type:"get",
		   data:{"fcNo" : "${requestScope.faqcategoryList.fcNo}"},
	   	   dataType:"json",
	   	   success:function(json) {
	   		alert("호이호이");
	   	   },
	   	   error: function(request, status, error){
         alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
      }
	   });// end of ajax--------------------
  });
  
  
});