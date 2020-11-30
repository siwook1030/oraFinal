package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import com.example.demo.dao.CourseDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.vo.CourseVo;
import com.google.gson.Gson;

@Controller
public class SearchCourseController {
	@Autowired
	private CourseDao cdao;
	
	@GetMapping("/searchCourse")
	public void searchCourseForm() {
		
	}
	
	@PostMapping(value ="/searchCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String searchCourse(double latitude, double longitude, int distance, int time,@RequestParam(value="view[]",required = false) List<String> view) {
		HashMap map = new HashMap();
		System.out.println("위도 : "+latitude);
		System.out.println("경도 : "+longitude);
		System.out.println("거리 : "+distance);
		System.out.println("시간 : "+time);
		System.out.println("풍경 : " + view);
		int minDis = 0;
		if(distance > 0) { 
			 minDis = 20;
		}
		if(distance >50) {
			minDis = 950;
		}
		
		int minTime = 0;
		if(time > 0) {
			 minTime = 60;
		}
		if(time > 180) {
			minTime = 820;
		}
		
		
		if(view != null) {
			int cnt=1;
			for(String v : view) {
				map.put("view"+cnt, v);
				cnt++;
			}
		}

		map.put("latitude", latitude);
		map.put("longitude", longitude);
		map.put("distance", distance);
		map.put("minDis", minDis);
		map.put("time", time);
		map.put("minTime", minTime);
		List<CourseVo> sclList = cdao.searchCourseList(map);
		
		Gson gson = new Gson();
		
		return gson.toJson(sclList);
		
	}
	
	@GetMapping("/tagSearchCourse")
	public void tagSearchCourseForm(Model model,@RequestParam(defaultValue = "0") String searchTag) {
		String [] tagArr = (searchTag.replaceAll(" ", "")).split(",");
		String tags = "";
		for(String t : tagArr) {
			if(!t.equals("") && t != null) {
				tags += t+"|";
			}
		}	
		tags = tags.substring(0, tags.length()-1);
		model.addAttribute("searchTag", tags);	
	}
	
	@PostMapping(value = "/tagSearchCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<CourseVo> tagSearchCourse(String searchTag) {
		String [] tagArr = (searchTag.replaceAll(" ", "")).split(",");
		String tags = "";
		for(String t : tagArr) {
			if(!t.equals("") && t != null) {
				tags += t+"|";
			}
		}	
		tags = tags.substring(0, tags.length()-1);
		return cdao.tagSearchCourseList(tags);
	}
	
/*	@PostMapping(value = "/speechSearch", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String speech(HttpServletRequest request, MultipartFile speak) {
		System.out.println(speak);
		String myPath = request.getRealPath("/adminImg")+"/speak.wav";
		
		
	//	FileUtilCollection.saveImage(speak, myPath);
//	String path2 = request.getRealPath("/adminImg")+"/speak2.wav";
		
		try {
			
			 AudioFormat.Encoding defaultEncoding = AudioFormat.Encoding.PCM_SIGNED;
			 float fDefaultSampleRate = 16000;
			 int nDefaultSampleSizeInBits = 16;
			 int nDefaultChannels = 1;
			 int frameSize = 2;
			 float frameRate = 44100;
			 boolean bDefaultBigEndian = false;
			AudioFormat defaultFormat = new AudioFormat(defaultEncoding, fDefaultSampleRate, nDefaultSampleSizeInBits, nDefaultChannels, frameSize, frameRate, bDefaultBigEndian);
		//	AudioInputStream GeneratedAudio = marytts.generateAudio(text); //generate audio from text
			//AudioInputStream GeneratedAudio = AudioSystem.getAudioInputStream(new File(myPath));
			AudioInputStream GeneratedAudio = AudioSystem.getAudioInputStream(speak.getInputStream());
			
			AudioInputStream audio = AudioSystem.getAudioInputStream(defaultFormat, GeneratedAudio);	
			AudioSystem.write(audio, AudioFileFormat.Type.WAVE, new File(myPath));
			System.out.println("오디오파일 : "+audio);

			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		String path = request.getRealPath("/adminImg")+"/heykakao.wav";
//		FileUtilCollection.saveImage(speak, path);
	    RestTemplate restTemplate = new RestTemplate();
	    restTemplate.getMessageConverters()
        .add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
	    
	    //add file
	    LinkedMultiValueMap<String, Object> params = new LinkedMultiValueMap<String, Object>();
	    params.add("file", new FileSystemResource(myPath));

	    //add array
	    UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl("https://kakaoi-newtone-openapi.kakao.com/v1/recognize");
	    //another staff
	    String result = "";
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
	        
	    headers.set("Transfer-Encoding", "chunked");	    
	    headers.set("X-DSS-Service", "DICTATION");
	    headers.set("Authorization", "KakaoAK 0f57515ee2bdb3942d39aad2a2b73740");
	    
	    HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity =
	            new HttpEntity<LinkedMultiValueMap<String, Object>>(params, headers);

	    ResponseEntity<String> responseEntity = restTemplate.exchange(
	            builder.build().encode().toUri(),
	            HttpMethod.POST,
	            requestEntity,
	            String.class
	    		);
	    HttpStatus statusCode = responseEntity.getStatusCode();
	    
	    result = responseEntity.getBody();
	    
	    
	    System.out.println(result);
	    return result;
	}*/
	
}
