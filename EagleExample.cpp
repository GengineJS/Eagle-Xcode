/*
 *  EagleExample.cpp
 *
 *  Copyright (c) 2016-2017 The Brenwill Workshop Ltd.
 *  This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
 */


#include "EagleExample.h"
#include "examples.h"

void EagleExample::renderFrame() {
    // _eagleApp->renderFrame();
}

void EagleExample::displayLinkOutputCb() {                        // SRS - expose VulkanExampleBase::displayLinkOutputCb() to DemoViewController
    _eagleApp->displayLinkOutputCb();
}

void EagleExample::keyPressed(uint32_t keyChar) {					// SRS - handle keyboard key presses only (e.g. Pause, Space, etc)
	switch (keyChar)
	{
		case KEY_P:
            // _eagleApp->paused = !_vulkanExample->paused;
			break;
		// case KEY_1:												// SRS - support keyboards with no function keys
		case KEY_F1:
            // _eagleApp->UIOverlay.visible = !_vulkanExample->UIOverlay.visible;
            // _eagleApp->UIOverlay.updated = true;
			break;
		default:
            _eagleApp->keyPressed(keyChar);
			break;
	}
}

void EagleExample::keyDown(uint32_t keyChar) {					// SRS - handle physical keyboard key down/up actions and presses
    switch (keyChar)
    {
		case KEY_W:
		// case KEY_Z:	// for French AZERTY keyboards
            // _eagleApp->camera.keys.up = true;
            break;
		case KEY_S:
            // _eagleApp->camera.keys.down = true;
            break;
		case KEY_A:
		// case KEY_Q:	// for French AZERTY keyboards
            // _eagleApp->camera.keys.left = true;
            break;
		case KEY_D:
            // _eagleApp->camera.keys.right = true;
            break;
        default:
            EagleExample::keyPressed(keyChar);
            break;
    }
}

void EagleExample::keyUp(uint32_t keyChar) {
    switch (keyChar)
    {
		case KEY_W:
            break;
		// case KEY_Z:	// for French AZERTY keyboards
            // _eagleApp->camera.keys.up = false;
        //    break;
		case KEY_S:
            // _eagleApp->camera.keys.down = false;
            break;
		case KEY_A:
		// case KEY_Q:	// for French AZERTY keyboards
            // _eagleApp->camera.keys.left = false;
            break;
		case KEY_D:
            // _eagleApp->camera.keys.right = false;
            break;
        default:
            break;
    }
}

void EagleExample::mouseDown(double x, double y) {
    _eagleApp->mousePos = glm::vec2(x, y);
    // _eagleApp->mouseButtons.left = true;
}

void EagleExample::mouseUp() {
    // _eagleApp->mouseButtons.left = false;
}

void EagleExample::rightMouseDown(double x, double y) {
    _eagleApp->mousePos = glm::vec2(x, y);
    // _eagleApp->mouseButtons.right = true;
}

void EagleExample::rightMouseUp() {
    // _eagleApp->mouseButtons.right = false;
}

void EagleExample::otherMouseDown(double x, double y) {
    _eagleApp->mousePos = glm::vec2(x, y);
    // _eagleApp->mouseButtons.middle = true;
}

void EagleExample::otherMouseUp() {
    // _eagleApp->mouseButtons.middle = false;
}

void EagleExample::mouseDragged(double x, double y) {
    _eagleApp->mouseDragged(x, y);
}

void EagleExample::scrollWheel(short wheelDelta) {
    // _eagleApp->camera.translate(glm::vec3(0.0f, 0.0f, wheelDelta * 0.05f * _eagleApp->camera.movementSpeed));
    // _eagleApp->viewUpdated = true;
}

void EagleExample::fullScreen(bool fullscreen) {
    // _eagleApp->settings.fullscreen = fullscreen;
}

EagleExample::EagleExample(void* view, double scaleUI, ESize size) {
    std::shared_ptr<EagleRenderer> renderer = EagleSetup();
    _eagleApp = std::make_shared<EagleApplication>(renderer);
    _eagleApp->setupWindow(view, size.width, size.height);
    _eagleApp->initialize();
    _eagleApp->renderLoop();
}

EagleExample::~EagleExample() {
    // delete(_eagleApp);
}
