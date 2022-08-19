/*
 *  DemoViewController.mm
 *
 *  Copyright (c) 2016-2017 The Brenwill Workshop Ltd.
 *  This code is licensed under the MIT license (MIT) (http://opensource.org/licenses/MIT)
 */

#import "DemoViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/CAMetalLayer.h>

#include "EagleExample.h"

/** Rendering loop callback function for use with a CVDisplayLink. */
static CVReturn DisplayLinkCallback(CVDisplayLinkRef displayLink,
                                    const CVTimeStamp* now,
                                    const CVTimeStamp* outputTime,
                                    CVOptionFlags flagsIn,
                                    CVOptionFlags* flagsOut,
                                    void* target) {
    //((EagleExample*)target)->renderFrame();
    ((EagleExample*)target)->displayLinkOutputCb();   // SRS - Call displayLinkOutputCb() to animate frames vs. renderFrame() for static image
    return kCVReturnSuccess;
}

CALayer* layer;
EagleExample* _eagleExample;

#pragma mark -
#pragma mark DemoViewController

@implementation DemoViewController {
    CVDisplayLinkRef _displayLink;
}

/** Since this is a single-view app, initialize Vulkan during view loading. */
-(void) viewDidLoad {
	[super viewDidLoad];

	self.view.wantsLayer = YES;		// Back the view with a layer created by the makeBackingLayer method (called immediately on set)

    _eagleExample = new EagleExample(self.view, layer.contentsScale);	// SRS - Use backing layer scale factor for UIOverlay on macOS

	// SRS - Enable AppDelegate to call into DemoViewController for handling application lifecycle events (e.g. termination)
	auto appDelegate = (AppDelegate *)NSApplication.sharedApplication.delegate;
	appDelegate.viewController = self;
	
    CVDisplayLinkCreateWithActiveCGDisplays(&_displayLink);
    CVDisplayLinkSetOutputCallback(_displayLink, &DisplayLinkCallback, _eagleExample);
    CVDisplayLinkStart(_displayLink);
}

-(void) shutdownExample {
	CVDisplayLinkStop(_displayLink);
    CVDisplayLinkRelease(_displayLink);
    delete _eagleExample;
}

@end


#pragma mark -
#pragma mark DemoView

@implementation DemoView

/** Indicates that the view wants to draw using the backing layer instead of using drawRect:.  */
-(BOOL) wantsUpdateLayer { return YES; }

/** Returns a Metal-compatible layer. */
+(Class) layerClass { return [CAMetalLayer class]; }

/** If the wantsLayer property is set to YES, this method will be invoked to return a layer instance. */
-(CALayer*) makeBackingLayer {
    layer = [self.class.layerClass layer];
    CGSize viewScale = [self convertSizeToBacking: CGSizeMake(1.0, 1.0)];
    layer.contentsScale = MIN(viewScale.width, viewScale.height);
    return layer;
}

// SRS - Activate mouse cursor tracking within the view, set view as window delegate, and center the window
- (void) viewDidMoveToWindow {
	auto trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options: (NSTrackingMouseMoved | NSTrackingActiveAlways | NSTrackingInVisibleRect) owner:self userInfo:nil];
	[self addTrackingArea: trackingArea];

	[self.window setDelegate: self.window.contentView];
	[self.window center];
}

-(BOOL) acceptsFirstResponder { return YES; }

// SRS - Handle keyboard events
-(void) keyDown:(NSEvent*) theEvent {
    NSString *text = [theEvent charactersIgnoringModifiers];
    unichar keychar = (text.length > 0) ? [text.lowercaseString characterAtIndex: 0] : 0;
    _eagleExample->keyDown(keychar);
}

-(void) keyUp:(NSEvent*) theEvent {
	NSString *text = [theEvent charactersIgnoringModifiers];
	unichar keychar = (text.length > 0) ? [text.lowercaseString characterAtIndex: 0] : 0;
    _eagleExample->keyUp(keychar);
}

// SRS - Handle mouse events
-(NSPoint) getMouseLocalPoint:(NSEvent*) theEvent {
    NSPoint location = [theEvent locationInWindow];
    NSPoint point = [self convertPointToBacking:location];
    point.y = self.frame.size.height*self.window.backingScaleFactor - point.y;
    return point;
}

-(void) mouseDown:(NSEvent*) theEvent {
    auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->mouseDown(point.x, point.y);
}

-(void) mouseUp:(NSEvent*) theEvent {
    _eagleExample->mouseUp();
}

-(void) rightMouseDown:(NSEvent*) theEvent {
	auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->rightMouseDown(point.x, point.y);
}

-(void) rightMouseUp:(NSEvent*) theEvent {
    _eagleExample->rightMouseUp();
}

-(void) otherMouseDown:(NSEvent*) theEvent {
	auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->otherMouseDown(point.x, point.y);
}

-(void) otherMouseUp:(NSEvent*) theEvent {
    _eagleExample->otherMouseUp();
}

-(void) mouseDragged:(NSEvent*) theEvent {
    auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->mouseDragged(point.x, point.y);
}

-(void) rightMouseDragged:(NSEvent*) theEvent {
    auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->mouseDragged(point.x, point.y);
}

-(void) otherMouseDragged:(NSEvent*) theEvent {
    auto point = [self getMouseLocalPoint:theEvent];
    _eagleExample->mouseDragged(point.x, point.y);
}

-(void) mouseMoved:(NSEvent*) theEvent {
	auto point = [self getMouseLocalPoint:theEvent];
	_eagleExample->mouseDragged(point.x, point.y);
}

-(void) scrollWheel:(NSEvent*) theEvent {
    short wheelDelta = [theEvent deltaY];
    _eagleExample->scrollWheel(wheelDelta);
}

- (void)windowWillEnterFullScreen:(NSNotification *)notification
{
	_eagleExample->fullScreen(true);
}

- (void)windowWillExitFullScreen:(NSNotification *)notification
{
	_eagleExample->fullScreen(false);
}

@end
