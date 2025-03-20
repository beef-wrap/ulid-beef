using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Interop;
using System.Text;

using static ulid.ulid;

namespace example;

static class Program
{
	static int Main(params String[] args)
	{
		ulid_generator gen = ?;
		ulid_generator_init(&gen, ULID_SECURE);
		char8[27] buf = .();
		ulid_generate(&gen, buf);

		ulid_generate(&gen, buf);
		Debug.WriteLine(StringView(&buf));

		ulid_generate(&gen, buf);
		Debug.WriteLine(StringView(&buf));

		ulid_generate(&gen, buf);
		Debug.WriteLine(StringView(&buf));

		return 0;
	}
}