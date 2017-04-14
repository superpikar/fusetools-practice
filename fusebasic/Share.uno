using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;
using Uno.UX;

using Uno.Compiler.ExportTargetInterop;

// credit https://www.fusetools.com/community/forums/bug_reports/fuse_preview_will_fail_to_compile_when_using_forei?page=1
[extern(Android) ForeignInclude(Language.Java, "android.content.Intent")]
[extern(Android) ForeignInclude(Language.Java, "com.fuse.Activity")]
[UXGlobalModule]
public class Share : NativeModule
{
    static readonly Share _instance;

    public Share()
    {
        // Make sure we're only initializing the module once
        if(_instance != null) return;

        _instance = this;
        Resource.SetGlobalKey(_instance, "Share");
        AddMember(new NativeFunction("sendIntent", (NativeCallback)SendIntent));
    }

    static object SendIntent(Context c, object[] args)
    {
        if defined(Android) SendIntent();
        if defined(iOS) SendIntent();

        return null;
    }

    [Foreign(Language.Java)]
    static extern(Android) void SendIntent()
    @{
        Intent sendIntent = new Intent();
        sendIntent.setAction(Intent.ACTION_SEND);
        sendIntent.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
        sendIntent.setType("text/plain");
        Activity.getRootActivity().startActivity(Intent.createChooser(sendIntent, "Share via..."));
    @}


    [Foreign(Language.ObjC)]
    static extern(iOS) void SendIntent()
    @{

      NSString *textToShare = @"www.google.com/%@";
        NSArray *itemsToShare = @[textToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities: nil];
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:activityVC animated:YES completion:nil];

    @}

    
}