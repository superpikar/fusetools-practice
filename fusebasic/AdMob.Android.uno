using Uno;
using Uno.UX;
using Uno.Compiler.ExportTargetInterop;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;

public class AdMob : Panel
{
    protected override IView CreateNativeView()
    {
        if defined(Android)
        {
            return new Android.AdMobView();
        }
        else if defined(iOS)
        {
            throw new NotImplementedException();
        }
        else
        {
            return base.CreateNativeView();
        }
    }
}

namespace Android
{
    using Fuse.Controls.Native.Android;

    [Require("Gradle.Repository","mavenCentral()")]
	[Require("Gradle.Dependency","compile('com.google.gms:google-services:3.0.0')")]
	[Require("Gradle.Dependency","compile('com.google.firebase:firebase-ads:9.4.0')")]

	[extern(Android) ForeignInclude(Language.Java, "com.google.android.gms.ads.AdRequest")]
	[extern(Android) ForeignInclude(Language.Java, "com.google.android.gms.ads.NativeExpressAdView")]
	[extern(Android) ForeignInclude(Language.Java, "com.google.android.gms.ads.AdSize")]
	[extern(Android) ForeignInclude(Language.Java, "com.google.android.gms.ads.MobileAds")]

	[extern(Android) ForeignInclude(Language.Java, "android.content.Intent")]
	[extern(Android) ForeignInclude(Language.Java, "com.fuse.Activity")]

    //extern(Android) public class AdMobView { }

    extern(Android) public class AdMobView : LeafView
    {

        static AdMobView()
        {
            Initialize();
        }

        public AdMobView() : base(Create())
        {

        }

        [Foreign(Language.Java)]
        static Java.Object Create()
        @{
            AdRequest adRequest = new AdRequest.Builder()
					.build();

			String adsID = "ca-app-pub-4449523596754513/3938573585";
			NativeExpressAdView adView = new NativeExpressAdView(Activity.getRootActivity());
	        adView.setAdSize(new AdSize(320,100));
	        adView.setAdUnitId(adsID);
	        adView.loadAd(adRequest);

			return adView;
        @}

        [Foreign(Language.Java)]
        static void Initialize()
        @{
			String appID = "ca-app-pub-4449523596754513~8299674780";
            MobileAds.initialize(Activity.getRootActivity(), appID);	// put app ID
        @}

    }
}