package com.ordbok.controller;

import java.util.concurrent.Callable;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.ordbok.service.OrdService;

@RestController
@RequestMapping("/restapi")
public class RestOrdController {
	@Autowired
	OrdService ordService;
	
	@RequestMapping(value = "/getTable", method = RequestMethod.GET)
	public Callable<Object> search() throws Exception {
		Callable<Object> callable = new Callable<Object>(){
			@Override
			public Object call() throws Exception {
				return ordService.search();
			}
		};
		return callable;
	}
	
	@RequestMapping(value="/createOrd",produces="application/json;")
	public 	@ResponseBody String create(HttpServletRequest request,
			@RequestParam(value="ord") String ord,
			@RequestParam(value="partofspeech") String partofspeech,
			@RequestParam(value="meaning",required=false) String meaning,
			@RequestParam(value="example",required=false) String example,
			@RequestParam(value="singularIndefinite",required=false) String singularIndefinite,
			@RequestParam(value="singularDefinite",required=false) String singularDefinite,
			@RequestParam(value="pluralIndefinite",required=false) String pluralIndefinite,
			@RequestParam(value="pluralDefinite",required=false) String pluralDefinite,
			@RequestParam(value="imperative",required=false) String imperative,
			@RequestParam(value="infinitive",required=false) String infinitive,
			@RequestParam(value="present",required=false) String present,
			@RequestParam(value="past",required=false) String past,
			@RequestParam(value="supine",required=false) String supine,
			@RequestParam(value="positive",required=false) String positive,
			@RequestParam(value="comparative",required=false) String comparative,
			@RequestParam(value="superlative",required=false) String superlative,
			@RequestParam(value="prefix",required=false) String prefix,
			@RequestParam(value="suffix",required=false) String suffix,
			@RequestParam(value="relatedword",required=false) String relatedword,
			@RequestParam(value="synonym",required=false) String synonym,
			@RequestParam(value="antonym",required=false) String antonym,
			@RequestParam(value="compound",required=false) String compound,
			@RequestParam(value="category",required=false) String category,
			@RequestParam(value="note",required=false) String note){

		var msg = ordService.create(ord, partofspeech, meaning, example, singularIndefinite, singularDefinite,
				pluralIndefinite, pluralDefinite, imperative, infinitive, present, past, supine,
				positive, comparative, superlative, prefix, suffix, relatedword, synonym, antonym, 
				compound, category, note);
		return msg;
	}
	
	@RequestMapping(value = "/getOrd", method = RequestMethod.GET)
	public Callable<Object> getWord() throws Exception {
		Callable<Object> callable = new Callable<Object>(){
			@Override
			public Object call() throws Exception {
				return ordService.getOrd();
			}
		};
		return callable;
	}
	
	@RequestMapping(value = "/getPrefixList", method = RequestMethod.GET)
	public Callable<Object> getPrefixList() throws Exception {
		Callable<Object> callable = new Callable<Object>(){
			@Override
			public Object call() throws Exception {
				return ordService.getPrefix();
			}
		};
		return callable;
	}
	
	@RequestMapping(value = "/getSuffixList", method = RequestMethod.GET)
	public Callable<Object> getSuffixList() throws Exception {
		Callable<Object> callable = new Callable<Object>(){
			@Override
			public Object call() throws Exception {
				return ordService.getSuffix();
			}
		};
		return callable;
	}
	
	@RequestMapping(value = "/getCategoryList", method = RequestMethod.GET)
	public Callable<Object> getCategory() throws Exception {
		Callable<Object> callable = new Callable<Object>(){
			@Override
			public Object call() throws Exception {
				return ordService.getCategory();
			}
		};
		return callable;
	}
	
	@RequestMapping(value="/deleteOrd",produces="application/json;")
	public 	@ResponseBody String delete(HttpServletRequest request,
			@RequestParam(value="ord") String ord,
			@RequestParam(value="partofspeech") String partofspeech){
		
		var msg = ordService.delete(ord, partofspeech);
		return msg;
	}
	
	@RequestMapping(value="/updateOrd",produces="application/json;")
	public 	@ResponseBody String update(HttpServletRequest request,
			@RequestParam(value="originalWord") String originalWord,
			@RequestParam(value="originalPartofspeech") String originalPartofspeech,
			@RequestParam(value="ord") String ord,
			@RequestParam(value="partofspeech") String partofspeech,
			@RequestParam(value="meaning",required=false) String meaning,
			@RequestParam(value="example",required=false) String example,
			@RequestParam(value="singularIndefinite",required=false) String singularIndefinite,
			@RequestParam(value="singularDefinite",required=false) String singularDefinite,
			@RequestParam(value="pluralIndefinite",required=false) String pluralIndefinite,
			@RequestParam(value="pluralDefinite",required=false) String pluralDefinite,
			@RequestParam(value="imperative",required=false) String imperative,
			@RequestParam(value="infinitive",required=false) String infinitive,
			@RequestParam(value="present",required=false) String present,
			@RequestParam(value="past",required=false) String past,
			@RequestParam(value="supine",required=false) String supine,
			@RequestParam(value="positive",required=false) String positive,
			@RequestParam(value="comparative",required=false) String comparative,
			@RequestParam(value="superlative",required=false) String superlative,
			@RequestParam(value="prefix",required=false) String prefix,
			@RequestParam(value="suffix",required=false) String suffix,
			@RequestParam(value="relatedword",required=false) String relatedword,
			@RequestParam(value="synonym",required=false) String synonym,
			@RequestParam(value="antonym",required=false) String antonym,
			@RequestParam(value="compound",required=false) String compound,
			@RequestParam(value="category",required=false) String category,
			@RequestParam(value="note",required=false) String note){
		
		var msg = ordService.update(originalWord, originalPartofspeech, ord, partofspeech, meaning, 
				example, singularIndefinite, singularDefinite, pluralIndefinite, pluralDefinite, 
				imperative, infinitive, present, past, supine, positive, comparative, superlative, 
				prefix, suffix, relatedword, synonym, antonym, compound, category, note);
		return msg;
	}
}