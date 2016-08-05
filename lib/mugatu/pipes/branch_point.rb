module Mugatu
  module Pipes
    class BranchPoint
      def call(*)
        output =
          Todd::System.call(
            "git", "merge-base",
            "origin/master",
            "HEAD"
          )

        output.strip
      end
    end
  end
end
