var fStartPost=1;if(window.feedburner_currPost!=null){window.feedburner_currPost++}else{window.feedburner_currPost=1}if(document.body.getAttribute("fStartPost")){fs=parseInt(document.body.getAttribute("fStartPost"));if(!isNaN(fs))fStartPost=fs}if(window.feedburner_startPostOverride!=null){fs=parseInt(window.feedburner_startPostOverride);if(!isNaN(fs))fStartPost=window.feedburner_startPostOverride}else{window.feedburner_startPostOverride=fStartPost}if(window.feedburner_currPost==fStartPost){feedSrc='http://feeds.feedburner.com/~s/jongalloway?i='+escape("http://weblogs.asp.net/jgalloway/archive/2006/11/20/top-10-dos-batch-tips-yes-dos-batch.aspx")+'&showad=true';document.write('<script src="'+feedSrc+'" type="text/javascript"></script>')}