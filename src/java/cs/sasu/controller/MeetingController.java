package cs.sasu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
@Controller
public class MeetingController {

    @GetMapping("/meeting")
    public String enterPage() {
        return "enter";
    }

    @GetMapping("/room")
    public String roomPage(@RequestParam String user, @RequestParam String to, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("to", to);
        return "room";
    }
}

