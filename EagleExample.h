/*
 *  EagleExample.h
 *
 *  Copyright (c) 2022 The XiangKuiZheng Ltd.
 *
 *  Code adapted from SaschaWillems/xcode example:
 *  https://github.com/SaschaWillems/Vulkan/tree/master/xcode
 *  This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
 */

#pragma once

#include "EagleApplication.h"

struct ESize {
    uint32_t width = 0;
    uint32_t height = 0;
};

class EagleExample {

public:
	void renderFrame();
    void displayLinkOutputCb();                     // SRS - expose
    
    void keyPressed(uint32_t keyChar);              // SRS - expose keyboard events to DemoViewController
    void keyDown(uint32_t keyChar);
    void keyUp(uint32_t keyChar);
    
    void mouseDown(double x, double y);             // SRS - expose mouse events to DemoViewController
    void mouseUp();
    void rightMouseDown(double x, double y);
    void rightMouseUp();
    void otherMouseDown(double x, double y);
    void otherMouseUp();
    void mouseDragged(double x, double y);
    void scrollWheel(short wheelDelta);
	
	void fullScreen(bool fullscreen);				// SRS - expose EagleApplication::settings.fullscreen to DemoView (macOS only)
	
    EagleExample(void* view, double scaleUI, ESize size = {});			// SRS - support UIOverlay scaling parameter based on device and display type
    ~EagleExample();

protected:
    std::shared_ptr<eg::EagleApplication> _eagleApp;
};



