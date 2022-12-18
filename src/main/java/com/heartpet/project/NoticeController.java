package com.heartpet.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.heartpet.action.NoticeDAO;
import com.heartpet.model.NoticeDTO;
import com.heartpet.model.PageDTO;

@Controller
public class NoticeController {

	@Autowired
    private NoticeDAO noticedao;
	
	// 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;
	
	@RequestMapping("/user_notice")
    public String notice(@RequestParam(value = "field", required = false) String field,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int page,Model model) {
		
		// 페이징
		if (field == null) {
            field = "";
        }
        if (keyword == null) {
            keyword = "";
        }
        
        int currentPage = 1; // 현재 페이지 변수
        if (page != 1) {
            currentPage = page;
        }
        
        List<NoticeDTO> noticeList = null;
        PageDTO paging= null;
		
        totalRecord = this.noticedao.listNoticeCount(field, keyword);
        paging = new PageDTO(currentPage, rowsize, totalRecord, field, keyword);
        noticeList = this.noticedao.listNotice(paging.getStartNo(), paging.getEndNo(), field, keyword);
		
        model.addAttribute("List", noticeList);
        model.addAttribute("total", totalRecord);
        model.addAttribute("paging", paging);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        /*
		 * List<NoticeDTO> list = noticedao.getNoticeList(); model.addAttribute("List",
		 * list)
		 */;
        return "user/notice/notice_list";
    }

	@RequestMapping("/user_notice_content")
    public String notice_content(@RequestParam("no") int no, Model model) {
    	NoticeDTO dto = this.noticedao.getNotice(no);
    	model.addAttribute("Cont", dto);
    	noticedao.readCount(no);
    	return "user/notice/notice_content";
    }
}
