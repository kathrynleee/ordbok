package com.ordbok.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ordbok.mybatis.client.OrdMapper;
import com.ordbok.mybatis.model.Ord;
import com.ordbok.mybatis.model.OrdExample;
import com.ordbok.mybatis.model.OrdKey;

@Service
@Transactional(rollbackFor=Exception.class)
public class OrdService {
	@Autowired
	public OrdMapper OrdMapper;
	
	public String search() throws Exception {
		DateFormat dataFormat = new SimpleDateFormat("yy/MM/dd");
		ObjectMapper objmp = new ObjectMapper();
		objmp.setDateFormat(dataFormat);
		objmp.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
		
		OrdExample example = new OrdExample();
		List<Ord> result = OrdMapper.selectByExample(example);
		HashMap<String, List<Ord>> map = new HashMap<String, List<Ord>>();
		map.put("data", result);
		try{
			String jsonObj = objmp.writeValueAsString(map);
			return jsonObj;
		} catch(Exception ex){
		}
		return null;
	}

	public String create(String ord, String partofspeech, String meaning, String example, String singularIndefinite,
			String singularDefinite, String pluralIndefinite, String pluralDefinite, String imperative,
			String infinitive, String present, String past, String supine, String positive, String comparative,
			String superlative, String prefix, String suffix, String relatedword, String synonym, String antonym,
			String compound, String category, String note) {

		OrdExample newRecord = new OrdExample();
		newRecord.createCriteria().andOrdEqualTo(ord).andPartofspeechEqualTo(partofspeech);
		Ord insObj = new Ord();
		if(ord!=null&&partofspeech!=null) {
			insObj.setOrd(ord);
			insObj.setPartofspeech(partofspeech);
			insObj.setMeaning(meaning);
			insObj.setExample(example);
			insObj.setSingularIndefinite(singularIndefinite);
			insObj.setSingularDefinite(singularDefinite);
			insObj.setPluralIndefinite(pluralIndefinite);
			insObj.setPluralDefinite(pluralDefinite);
			insObj.setImperative(imperative);
			insObj.setInfinitive(infinitive);
			insObj.setPresent(present);
			insObj.setPast(past);
			insObj.setSupine(supine);
			insObj.setPositive(positive);
			insObj.setComparative(comparative);
			insObj.setSuperlative(superlative);
			insObj.setPrefix(prefix);
			insObj.setSuffix(suffix);
			insObj.setRelatedword(relatedword);
			insObj.setSynonym(synonym);
			insObj.setAntonym(antonym);
			insObj.setCompound(compound);
			insObj.setCategory(category);
			insObj.setNote(note);
			insObj.setCreatedDate(new Date());
		}
		
		ObjectMapper objmp = new ObjectMapper();
		String msg = "";
		try{
			if(OrdMapper.countByExample(newRecord)>0)
				msg = "Duplicate record";
			if(OrdMapper.insert(insObj)>0)
				msg = "Success";
		} catch (DuplicateKeyException ex) {
			msg = "Duplicate record";
		} catch (Exception ex){
			msg = "Error";
		}
		try{
			return objmp.writeValueAsString(msg);
		} catch(Exception ex){
			return null;
		}
	}

	public String getOrd() {
		ObjectMapper objmp = new ObjectMapper();
		objmp.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
		List<Ord> result = OrdMapper.getOrd();
		try{
			String jsonObj = objmp.writeValueAsString(result);
			return jsonObj;
		} catch(Exception ex){
		}
		return null;
	}
	
	public String getPrefix() {
		ObjectMapper objmp = new ObjectMapper();
		objmp.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
		List<Ord> result = OrdMapper.getPrefix();
		try{
			String jsonObj = objmp.writeValueAsString(result);
			return jsonObj;
		} catch(Exception ex){
		}
		return null;
	}
	
	public String getSuffix() {
		ObjectMapper objmp=new ObjectMapper();
		objmp.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
		List<Ord> result = OrdMapper.getSuffix();
		try{
			String jsonObj = objmp.writeValueAsString(result);
			return jsonObj;
		} catch(Exception ex){
		}
		return null;
	}
	
	public String getCategory() {
		ObjectMapper objmp = new ObjectMapper();
		objmp.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
		List<Ord> result = OrdMapper.getCategory();
		try{
			String jsonObj = objmp.writeValueAsString(result);
			return jsonObj;
		} catch(Exception ex){
		}
		return null;
	}

	public String delete(String ord, String partofspeech) {
		OrdKey key = new OrdKey();
		key.setOrd(ord);
		key.setPartofspeech(partofspeech);
		ObjectMapper objmp = new ObjectMapper();
		String msg = "";
		try{
			if(OrdMapper.deleteByPrimaryKey(key)>0)
				msg = "Success";
		} catch (Exception ex){
			msg = "Error";
		}
		try{
			return objmp.writeValueAsString(msg);
		} catch(Exception ex){
			return null;
		}
	}

	public String update(String originalWord, String originalPartofspeech, String ord, String partofspeech,
			String meaning, String example, String singularIndefinite, String singularDefinite, String pluralIndefinite,
			String pluralDefinite, String imperative, String infinitive, String present, String past, String supine,
			String positive, String comparative, String superlative, String prefix, String suffix, String relatedword,
			String synonym, String antonym, String compound, String category, String note) {
		
		OrdExample record = new OrdExample();
		record.createCriteria().andOrdEqualTo(originalWord).andPartofspeechEqualTo(originalPartofspeech);
		Ord obj = new Ord();
		
		if(ord!=null && partofspeech!=null) {
			obj.setOrd(ord);
			obj.setPartofspeech(partofspeech);
			obj.setMeaning(meaning);
			obj.setExample(example);
			obj.setSingularIndefinite(singularIndefinite);
			obj.setSingularDefinite(singularDefinite);
			obj.setPluralIndefinite(pluralIndefinite);
			obj.setPluralDefinite(pluralDefinite);
			obj.setImperative(imperative);
			obj.setInfinitive(infinitive);
			obj.setPresent(present);
			obj.setPast(past);
			obj.setSupine(supine);
			obj.setPositive(positive);
			obj.setComparative(comparative);
			obj.setSuperlative(superlative);
			obj.setPrefix(prefix);
			obj.setSuffix(suffix);
			obj.setRelatedword(relatedword);
			obj.setSynonym(synonym);
			obj.setAntonym(antonym);
			obj.setCompound(compound);
			obj.setCategory(category);
			obj.setNote(note);
			obj.setCreatedDate(new Date());
		}
		
		OrdExample query = new OrdExample();
		query.createCriteria().andOrdEqualTo(ord).andPartofspeechEqualTo(partofspeech);
		
		ObjectMapper objmp = new ObjectMapper();
		try{
			if(!originalWord.equals(ord) || !originalPartofspeech.equals(partofspeech)) {
				if(OrdMapper.countByExample(query)>0) {
					return objmp.writeValueAsString("Duplicate record");
				}
			}
			if(OrdMapper.updateByExample(obj, record)>0)
				return objmp.writeValueAsString("Success");
		} catch (DuplicateKeyException ex) {
		} catch (Exception ex){
		}
		return null;
	}
}