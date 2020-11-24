package com.example.demo.scheduler;



import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.attribute.FileTime;
import java.util.concurrent.TimeUnit;

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
	
	// review_temp폴더 파일들의 생성날짜 확인하여 24시간 지난 것은 삭제
	@Scheduled(cron = "0 30 4 * * *") // 매일 오전 4시 30분마다 실행
	public void deleteOldReviewTemp() {
		System.out.println("deleteOldReviewTemp() 스케쥴러 동작");
		String path = sc.getRealPath("/review_temp");
		File folder = new File(path);
		// 파일필터정책에 걸린 것만 리스트로 추출해서 삭제
		for(File fileEntry : folder.listFiles(new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				// TODO Auto-generated method stub
				boolean isOver24hours = false;
				try {
					FileTime creationTime = (FileTime)Files.getAttribute(pathname.toPath(), "creationTime");
					if(System.currentTimeMillis() - creationTime.toMillis() > 86400000) {
						isOver24hours = true;
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//Files.getAttribute(path, attribute, options)
				return isOver24hours;
			}
		})) {
			fileEntry.delete();
		}
	}
	
	// meeting_temp폴더 파일들의 생성날짜 확인하여 24시간 지난 것은 삭제
		@Scheduled(cron = "0 40 4 * * *") // 매일 오전 4시 40분마다 실행
		public void deleteOldMeetingTemp() {
			System.out.println("deleteOldMeetingTemp() 스케쥴러 동작");
			String path = sc.getRealPath("/meeting_temp");
			File folder = new File(path);
			// 파일필터정책에 걸린 것만 리스트로 추출해서 삭제
			for(File fileEntry : folder.listFiles(new FileFilter() {
				@Override
				public boolean accept(File pathname) {
					// TODO Auto-generated method stub
					boolean isOver24hours = false;
					try {
						FileTime creationTime = (FileTime)Files.getAttribute(pathname.toPath(), "creationTime");
						if(System.currentTimeMillis() - creationTime.toMillis() > 86400000) {
							isOver24hours = true;
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					//Files.getAttribute(path, attribute, options)
					return isOver24hours;
				}
			})) {
				fileEntry.delete();
			}
		}
}
