package cs.sasu;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

public class Captcha {

    private static final String CHAR_SET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int CAPTCHA_WIDTH = 160;
    private static final int CAPTCHA_HEIGHT = 50;
    private static final int FONT_SIZE = 30;

    // 生成验证码字符串
    public String generateCaptchaCode() {
        StringBuilder captchaCode = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            captchaCode.append(CHAR_SET.charAt(random.nextInt(CHAR_SET.length())));
        }
        return captchaCode.toString();
    }

    // 生成验证码图片
    public BufferedImage generateCaptchaImage(String captchaCode) {
        BufferedImage image = new BufferedImage(CAPTCHA_WIDTH, CAPTCHA_HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();

        // 填充背景
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, CAPTCHA_WIDTH, CAPTCHA_HEIGHT);

        // 设置字体
        Font font = new Font("Arial", Font.BOLD, FONT_SIZE);
        graphics.setFont(font);

        // 设置验证码文本颜色
        graphics.setColor(Color.BLACK);
        graphics.drawString(captchaCode, 30, 35);

        // 添加干扰线
        Random random = new Random();
        for (int i = 0; i < 5; i++) {
            graphics.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
            graphics.drawLine(random.nextInt(CAPTCHA_WIDTH), random.nextInt(CAPTCHA_HEIGHT),
                    random.nextInt(CAPTCHA_WIDTH), random.nextInt(CAPTCHA_HEIGHT));
        }

        graphics.dispose();
        return image;
    }
}


