package com.example.demo.scheduler;



import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.annotation.Schedules;
import org.springframework.stereotype.Component;

import com.example.demo.util.FileUtilCollection;

@Component
@EnableScheduling
public class Scheduler {
	
	@Autowired
	private ServletContext sc;

	@Scheduled(cron = "0 0 4 * * *")  // 매일 오전4시 마다 실행
	public void deletePreviewPhoto() {
		System.out.println("스케줄링 작동함");
		String previewPhotoPath = sc.getRealPath("/previewPhoto");
		FileUtilCollection.deleteFilesInFolder(previewPhotoPath);
	}
}
